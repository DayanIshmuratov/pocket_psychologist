import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';
import '../core/logger/logger.dart';
import '../core/server/account.dart';
import 'package:sqflite_common/sqlite_api.dart';

class Utilities {
  checkAnswersSignIn(BuildContext context) async {
    final localdb = await DBProvider.db.database;
    final remotedb = Databases(AppWriteProvider().client);
    final user = await AccountProvider().account.get();
    final localAnswers = await localdb
        .rawQuery(
        'SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
    final remoteAnswers = await remotedb.listDocuments(
        databaseId: 'users_answers',
        collectionId: user.$id,
        // queries: [Query.equal('user_id', [user.$id])]
    );
    if (localAnswers.isNotEmpty && remoteAnswers.total == 0) {
      await loadToServer(localAnswers, user, remotedb);
    } else if (localAnswers.isNotEmpty && remoteAnswers.total != 0) {
      return showDialog(context: context, builder: (context) {
        return SimpleDialog(
          title: AppSubtitle(value: 'Обнаружено наложение данных'),
          children: [
            Row(children: [
              ElevatedButton(onPressed: () {
                loadToDB(remoteAnswers, localdb);
              }, child: AppText(value: "Из сервера")),
              ElevatedButton(onPressed: () {
                loadToServer(localAnswers, user, remotedb);
              }, child: AppText(value: "Из БД")),
            ],)
          ],
        );
      });
      logger.info("Обе БД содержат данные");
    } else if (localAnswers.isEmpty && remoteAnswers.total != 0) {
      loadToDB(remoteAnswers, localdb);
    }
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

  Future<void> loadToServer(List<Map<String, Object?>> localAnswers,
      models.Account user, Databases remotedb) async {
    // await remotedb.deleteDocument(
    //     databaseId:  ID.custom('users_answers'),
    //     collectionId: ID.custom(user.$id),
    //     documentId: '',
    //     );
    // Map<String, dynamic> map = {};
    // localAnswers.map((e) => map.addAll());
    for (var mapRead in localAnswers) {
      Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
      await remotedb.createDocument(
        databaseId: ID.custom('users_answers'),
        collectionId: ID.custom(user.$id),
        documentId: ID.unique(),
        data: map,
      );
    }
  }

  // Map<String, dynamic> addingId(Map<String, dynamic> map, String userId) {
  //   map.addAll({'user_id': userId});
  //   return map;
  // }

  checkAnswersSignUp() async {
    final localdb = await DBProvider.db.database;
    final remotedb = Databases(AppWriteProvider().client);
    final user = await AccountProvider().account.get();
    final localAnswers = await localdb
        .rawQuery('SELECT question_id, question_answer_id from questions');
    if (localAnswers.isNotEmpty) {
      loadToServer(localAnswers, user, remotedb);
    }
  }



}


//import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart' as models;
// import 'package:appwrite/models.dart';
// import 'package:flutter/material.dart';
// import 'package:pocket_psychologist/common/components/text.dart';
// import 'package:pocket_psychologist/core/db/database.dart';
// import 'package:pocket_psychologist/core/server/appwrite.dart';
// import '../core/logger/logger.dart';
// import '../core/server/account.dart';
// import 'package:sqflite_common/sqlite_api.dart';
//
// class Utilities {
//   checkAnswersSignIn(BuildContext context) async {
//     final localdb = await DBProvider.db.database;
//     final remotedb = Databases(AppWriteProvider().client);
//     final user = await AccountProvider().account.get();
//     final localAnswers = await localdb
//         .rawQuery(
//         'SELECT question_id, question_answer_id from questions WHERE question_answer_id != 0');
//     final remoteAnswers = await remotedb.listDocuments(
//         databaseId: 'default',
//         collectionId: 'users_answers',
//         queries: [Query.equal('user_id', [user.$id])]);
//     if (localAnswers.isNotEmpty && remoteAnswers.total == 0) {
//       await loadToServer(localAnswers, user, remotedb);
//     } else if (localAnswers.isNotEmpty && remoteAnswers.total != 0) {
//       return showDialog(context: context, builder: (context) {
//         return SimpleDialog(
//           title: AppSubtitle(value: 'Обнаружено наложение данных'),
//           children: [
//             Row(children: [
//               ElevatedButton(onPressed: () {
//                 loadToDB(remoteAnswers, localdb);
//               }, child: AppText(value: "Из сервера")),
//               ElevatedButton(onPressed: () {
//                 loadToServer(localAnswers, user, remotedb);
//               }, child: AppText(value: "Из БД")),
//             ],)
//           ],
//         );
//       });
//       logger.info("Обе БД содержат данные");
//     } else if (localAnswers.isEmpty && remoteAnswers.total != 0) {
//       loadToDB(remoteAnswers, localdb);
//     }
//   }
//
//   void loadToDB(models.DocumentList remoteAnswers, Database localdb) async {
//     List<Document> documents = remoteAnswers.documents;
//     for (int i = 0; i < documents.length; i++) {
//       documents[i].data.removeWhere((key, value) =>
//       key != 'question_id' && key != 'question_answer_id');
//       // await localdb.update('questions',  documents[i].data, where: 'question_id = ?', whereArgs: [documents[i].data['question_answer_id']]);
//       await localdb.rawUpdate(
//           'UPDATE questions SET question_answer_id = ${documents[i]
//               .data['question_answer_id']} WHERE question_id = ${documents[i]
//               .data['question_id']}');
//     }
//   }
//
//   Future<void> loadToServer(List<Map<String, Object?>> localAnswers,
//       models.Account user, Databases remotedb) async {
//     await remotedb.deleteDocument(
//         databaseId:  ID.custom('default'),
//         collectionId: ID.custom('users_answers'),
//         documentId: '',
//         );
//     List<Map<String, dynamic>> maps = localAnswers;
//     // Map<String, dynamic> map = {};
//     // localAnswers.map((e) => map.addAll());
//     for (var mapRead in maps) {
//       Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
//       await remotedb.createDocument(
//         databaseId: ID.custom('default'),
//         collectionId: ID.custom('users_answers'),
//         documentId: ID.unique(),
//         data: addingId(map, user.$id),
//       );
//     }
//   }
//
//   Map<String, dynamic> addingId(Map<String, dynamic> map, String userId) {
//     map.addAll({'user_id': userId});
//     return map;
//   }
//
//   checkAnswersSignUp() async {
//     final localdb = await DBProvider.db.database;
//     final remotedb = Databases(AppWriteProvider().client);
//     final user = await AccountProvider().account.get();
//     final localAnswers = await localdb
//         .rawQuery('SELECT question_id, question_answer_id from questions');
//     if (localAnswers.isNotEmpty) {
//       loadToServer(localAnswers, user, remotedb);
//     }
//   }
//
//
//
// }