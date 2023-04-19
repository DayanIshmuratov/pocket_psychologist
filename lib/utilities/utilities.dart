import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as constants;
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';
import 'package:pocket_psychologist/core/server/database.dart';
import '../core/logger/logger.dart';
import '../core/server/account.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../core/server/appwrite_server.dart';




  checkAnswersSignIn(BuildContext context) async {
    final localdb = await DBProvider.db.database;
    final remotedb = Databases(AppWriteProvider().client);
    final user = await AccountProvider.get().account.get();
    final localAnswers = await loadFromLocalDB(localdb);
    final remoteAnswers = await loadFromRemoteDB(remotedb, user);
    if (localAnswers.isNotEmpty && remoteAnswers.total == 0) {
      await loadToServer(localAnswers, user, remotedb, true);
    }
    else if (localAnswers.isNotEmpty && remoteAnswers.total != 0) {
      return showDialog(context: context, builder: (context) {
        return SimpleDialog(
          title: AppText(value: 'Локальное и серверное хранилище содержат отличающиеся данные. Во избежание проблем выберите одну из хранилищ, откуда будут получены данные и в дальнейшем использованы.'),
          children: [
            Row(children: [
              ElevatedButton(onPressed: () {
                loadToDB(remoteAnswers, localdb);
              }, child: AppText(value: "Удаленный сервер")),
              ElevatedButton(onPressed: () {
                loadToServer(localAnswers, user, remotedb, true);
              }, child: AppText(value: "Локальное хранилище")),
            ],)
          ],
        );
      }
      );
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

  checkAnswersSignUp() async {
    final localdb = await DBProvider.db.database;
    final remotedb = AppWriteDBProvider().db;
    final user = await AccountProvider.get().account.get();
    final localAnswers = await localdb
        .rawQuery('SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
    await loadToServer(localAnswers, user, remotedb, false);
  }

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
