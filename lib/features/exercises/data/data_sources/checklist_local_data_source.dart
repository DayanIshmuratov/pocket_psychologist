import 'package:flutter/services.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/checklist_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';

abstract class CheckListLocalDataSource<T> {
  Future<List<CheckListModel>> getCheckLists();
  Future<QuestionModel> getQuestion(int nameId, int questionId);
  Future<void> updateAnswer(AnswerModel model);
  Future<void> updateCheckList(CheckListModel model);
  // Future<T> getEntity(int id, String tableName);
  // Future<List<T>> getEntityLists(String tableName, Function fromJson);
  // Future<void> updateById(T entity, String tableName);
}

class CheckListLocalDataSourceImpl<T> extends CheckListLocalDataSource {
  final DBProvider db;

  CheckListLocalDataSourceImpl({required this.db});

  // @override
  // Future<T> getEntity(int id, String tableName) async {
  //   var _database = await db.database;
  //   var _data = _database.query(tableName, where: "name_id = ?", whereArgs: [id]);
  //   throw 'error';
  //   // return T.fromJson();
  // }
  //
  // @override
  // Future<List<T>> getEntityLists(String tableName, Function fromJson) async {
  //   var _database = await db.database;
  //   var _data = _database.query(tableName);
  //   return T.fromJson();
  // }
  //
  // @override
  // Future<void> updateById(T entity, String tableName, int id, Function toMap) async {
  //   var _database = await db.database;
  //   await _database.update('tableName', entity.toMap(), where: "name_id", whereArgs: [entity.id]);
  //
  //   throw 'error';
  // }




  @override
  Future<List<CheckListModel>> getCheckLists() async {
    // var _database = await rootBundle('assets/databases/sqlite.db');
    // var _data = _database.
    var database = await db.database;
    var data = await database.rawQuery("SELECT checklist_id, checklist_name, description, instruction, sum, done, count FROM check_lists");
    var result = data.map((e) => CheckListModel.fromJson(e)).toList();
    return result;
  }

  Future<void> updateAnswer(AnswerModel model) async {
    // Uint8List answers = Uint8List.fromList(checkListModel.questions.answer);
    var database = await db.database;
    // await _database.rawUpdate("UPDATE questions SET answers = ${questionModel.answerId} WHERE name_id = ${questionModel.nameId}");
    await database.update("answers", model.toMap(), where: "answer_id = ?", whereArgs: [model.id]);
    // for (int i in checkListModel.questions.answer) {
    //   await _database.update("questions", {'answers' : i}, where: 'name_id = ${checkListModel.id}');
    // }
    //
    // for (int i = 0; i < checkListModel.questions.answer.length; i++) {
    //   await _database.update("questions", {'answers' : checkListModel.questions.answer[i]}, where: 'question_id = ${checkListModel.questions.id[i]}');
    // }
  }

  @override
  Future<QuestionModel> getQuestion(int nameId, int questionId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT question_id, question, name_id, GROUP_CONCAT(answer_id, '@') as answer_id, GROUP_CONCAT(answer_name, '@') as answer_name, GROUP_CONCAT(value, '@') as value, GROUP_CONCAT(lie_value, '@') as lie_value, GROUP_CONCAT(is_choosen, '@') as is_choosen FROM questions INNER JOIN answers USING(question_id) INNER JOIN answers_name USING(answer_name_id) WHERE name_id = $nameId AND question_id = $questionId");
    var result = QuestionModel.fromJson(data[0]);
    return result;
  }



  @override
  Future<void> updateCheckList(CheckListModel model) async {
    var database = await db.database;
    await database.update("check_lists", model.toMap(), where: "checklist_id = ?", whereArgs: [model.id]);
  }
}