import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/cupertino.dart';
import 'package:pocket_psychologist/common/widgets/dialogs.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/db/database.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/server/account.dart';
import '../../../../core/server/appwrite.dart';
import '../../../../core/server/appwrite_server.dart';
import '../../../../core/server/database.dart';
import '../../domain/entity/userData.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as constants;

final appWriteServerProvider = AppWriteServerProvider();

Future<void> checkAnswers(UserData userData, BuildContext context) async {
  final localdb = await DBProvider.db.database;
  final remotedb = AppWriteDBProvider().db;
  final localAnswers = await loadFromLocalDB(localdb);
  try {
    await loadFromRemoteDB(remotedb, userData);
  } on AppwriteException {
    await appWriteServerProvider.createCollection(userData.id);
  }
  final remoteAnswers = await loadFromRemoteDB(remotedb, userData);
  if (localAnswers.isNotEmpty && remoteAnswers.total == 0) {
    await loadToServer(localAnswers, userData, remotedb, false);
  }
  else if ((localAnswers.isNotEmpty && remoteAnswers.total != 0) && (localAnswers.length != remoteAnswers.total)) {
    await Dialogs.showDataConfirmationDialog(context,
            loadToDB,
            loadToServer,
        remoteAnswers, localdb, localAnswers, userData, remotedb, true
    );
    logger.info("Обе БД содержат данные");
  } else if (localAnswers.isEmpty && remoteAnswers.total != 0) {
    loadToDB(remoteAnswers, localdb);
  }
}

Future<models.DocumentList> loadFromRemoteDB(Databases remotedb, UserData user) {
  return remotedb.listDocuments(
    databaseId: constants.appwriteUsersAnswersDatabaseId,
    collectionId: user.id,
    // queries: [Query.equal('user_id', [user.$id])]
  );
}

Future<List<Map<String, Object?>>> loadFromLocalDB(Database localdb) async {
  return await localdb
      .rawQuery(
      'SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
}

Future<void> loadToDB(models.DocumentList remoteAnswers, Database localdb) async {
  List<models.Document> documents = remoteAnswers.documents;
  DBProvider.resetDB();
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

checkAnswersSignUp(UserData userData) async {
  final localdb = await DBProvider.db.database;
  final remotedb = AppWriteDBProvider().db;
  final localAnswers = await localdb
      .rawQuery('SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
  await loadToServer(localAnswers, userData, remotedb, false);
}

Future<void> loadToServer(List<Map<String, Object?>> localAnswers,
    UserData user, Databases remotedb, bool delete) async {
  if (delete) {
    await appWriteServerProvider.deleteCollection(user.id);
    await appWriteServerProvider.createCollection(user.id);
  }
  for (var mapRead in localAnswers) {
    Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
    await remotedb.createDocument(
      databaseId: ID.custom(constants.appwriteUsersAnswersDatabaseId),
      collectionId: ID.custom(user.id),
      documentId: ID.unique(),
      data: map,
    );
  }
}

Future<void> checkDistinction(UserData userData) async {
  final localAnswers = await loadFromLocalDB(await DBProvider.db.database);
  final remoteAnswers = await loadFromRemoteDB(AppWriteDBProvider().db, userData);
  if (localAnswers.length > remoteAnswers.total) {
    loadToServer(localAnswers, userData, AppWriteDBProvider().db, true);
  }
}

String errorTypeToString(String type) {
  switch (type) {
    case 'user_invalid_credentials' : return "Неправильная почта или пароль.";
    case 'user_blocked' : return 'Пользователь заблокирован.';
    case 'user_already_exists' : return 'Пользователь уже существует';
  }
  return type;
}

Future<void> isReady(Function callback) async {
  int i = 40;
  while (i > 0) {
    await Future.delayed(const Duration(seconds: 2)).then((value)  async {
      try {
        await callback;
      } on Exception catch (e) {
        logger.info(e.toString());
        logger.info(i);
      }
    });
    i--;
  }
}
