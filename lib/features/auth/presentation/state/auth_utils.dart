import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/db/database.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/server/account.dart';
import '../../../../core/server/appwrite.dart';
import '../../../../core/server/appwrite_server.dart';
import '../../../../core/server/database.dart';
import '../widgets/dialogs.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as constants;

Future<void> checkAnswersSignIn() async {
  final localdb = await DBProvider.db.database;
  final remotedb = AppWriteDBProvider().db;
  final user = await AccountProvider.get().account.get();
  final localAnswers = await loadFromLocalDB(localdb);
  final remoteAnswers = await loadFromRemoteDB(remotedb, user);
  if (localAnswers.isNotEmpty && remoteAnswers.total == 0) {
    await loadToServer(localAnswers, user, remotedb, true);
  }
  else if (localAnswers.isNotEmpty && remoteAnswers.total != 0) {
    const DataTransferConfirmDialog(loadToServer: loadToServer, loadToDB: loadToDB);
    logger.info("Обе БД содержат данные");
  } else if (localAnswers.isEmpty && remoteAnswers.total != 0) {
    loadToDB(remoteAnswers, localdb);
  }
}

Future<models.DocumentList> loadFromRemoteDB(Databases remotedb, user) {
  return remotedb.listDocuments(
    databaseId: constants.appwriteUsersAnswersDatabaseId,
    collectionId: user.$id,
    // queries: [Query.equal('user_id', [user.$id])]
  );
}

Future<List<Map<String, Object?>>> loadFromLocalDB(Database localdb) async {
  return await localdb
      .rawQuery(
      'SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
}

void loadToDB(models.DocumentList remoteAnswers, Database localdb) async {
  List<Document> documents = remoteAnswers.documents;
  for (int i = 0; i < documents.length; i++) {
    documents[i].data.removeWhere((key, value) =>
    key != 'question_id' && key != 'question_answer_id');
    // await localdb.update('questions',  documents[i].data, where: 'question_id = ?', whereArgs: [documents[i].data['question_answer_id']]);
    await localdb.rawUpdate(
        'UPDATE questions SET question_answer_id = ${documents[i]
            .data['question_answer_id']} WHERE question_id = ${documents[i]
            .data['question_id']}');
  }
}

// checkAnswersSignUp() async {
//   final localdb = await DBProvider.db.database;
//   final remotedb = AppWriteDBProvider().db;
//   final user = await AccountProvider.get().account.get();
//   final localAnswers = await localdb
//       .rawQuery('SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
//   await loadToServer(localAnswers, user, remotedb, false);
// }

Future<void> loadToServer(List<Map<String, Object?>> localAnswers,
    models.Account user, Databases remotedb, bool delete) async {
  final appWriteServerProvider = AppWriteServerProvider();
  if (delete) {
    await appWriteServerProvider.deleteCollection(user.$id);
  }
  await appWriteServerProvider.createCollection(user.$id);
  for (var mapRead in localAnswers) {
    Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
    await remotedb.createDocument(
      databaseId: ID.custom(constants.appwriteUsersAnswersDatabaseId),
      collectionId: ID.custom(user.$id),
      documentId: ID.unique(),
      data: map,
    );
  }
}

Future<void> checkDistinction(models.Account user) async {
  final localAnswers = await loadFromLocalDB(await DBProvider.db.database);
  final remoteAnswers = await loadFromRemoteDB(AppWriteDBProvider().db, user);
  if (localAnswers.length > remoteAnswers.total) {
    loadToServer(localAnswers, user, AppWriteDBProvider().db, true);
  }
}

String errorTypeToString(String type) {
  switch (type) {
    case 'user_invalid_credentials' : return "Неправильная почта или пароль.";
    case 'user_blocked' : return 'Пользователь заблокирован.';
  }
  return type;
}
