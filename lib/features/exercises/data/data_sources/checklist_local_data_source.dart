import 'package:flutter/services.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/checklist_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/exercise_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/image_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/lie_result_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_with_answer_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/result_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';

abstract class CheckListLocalDataSource<T> {
  Future<List<ResultModel>> getResults(int nameId);
  Future<List<LieResultModel>> getLieResults(int nameId);
  Future<List<ExercisesModel>> getExercises(int nameId);
  Future<List<ImageModel>> getImages(int exerciseId);
  Future<List<CheckListModel>> getCheckLists(int checklistId);
  Future<List<QuestionWithAnswerModel>> getQuestionWithAnswer(int nameId);

  Future<List<QuestionModel>> getQuestions(int nameId);

  Future<List<AnswerModel>> getAnswers(int questionId);

  Future<void> updateQuestion(QuestionModel model);
// Future<T> getEntity(int id, String tableName);
// Future<List<T>> getEntityLists(String tableName, Function fromJson);
// Future<void> updateById(T entity, String tableName);
}

class CheckListLocalDataSourceImpl<T> extends CheckListLocalDataSource {
  final DBProvider db;

  CheckListLocalDataSourceImpl({required this.db});

  @override
  Future<List<CheckListModel>> getCheckLists(int checklistId) async {
    // var _database = await rootBundle('assets/databases/sqlite.db');
    // var _data = _database.
    var database = await db.database;
    if (checklistId == 0) {
      var data = await database.rawQuery('''SELECT checklist_id, checklist_name, description, instruction, 
      (SELECT (CASE WHEN SUM(value) IS NULL THEN 0 ELSE SUM(value) END) as sum FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as sum,
    (SELECT (CASE WHEN SUM(lie_value) IS NULL THEN 0 ELSE SUM(lie_value) END) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as lie_sum,
    (SELECT COUNT(question_answer_id) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as done, (SELECT COUNT(question_id) FROM questions WHERE questions.name_id = checklist_id) as count FROM check_lists''');
      var result = data.map((e) => CheckListModel.fromJson(e)).toList();
      return result;
    } else {
      var data = await database.rawQuery('''SELECT checklist_id, checklist_name, description, instruction, 
      (SELECT (CASE WHEN SUM(value) IS NULL THEN 0 ELSE SUM(value) END) as sum FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as sum,
    (SELECT (CASE WHEN SUM(lie_value) IS NULL THEN 0 ELSE SUM(lie_value) END) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as lie_sum,
    (SELECT COUNT(question_answer_id) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.name_id = checklist_id AND questions.question_answer_id != 0) as done, (SELECT COUNT(question_id) FROM questions WHERE questions.name_id = checklist_id) as count FROM check_lists WHERE checklist_id = ${checklistId}''');
      var result = data.map((e) => CheckListModel.fromJson(e)).toList();
      return result;
    }
  }

  @override
  Future<List<QuestionModel>> getQuestions(int nameId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT question_id, question, name_id, question_answer_id FROM questions WHERE name_id = $nameId");
    var result = data.map((e) => QuestionModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<void> updateQuestion(QuestionModel model) async {
    var database = await db.database;
    await database.update("questions", model.toMap(), where: 'question_id = ?', whereArgs: [model.id]);
  }

  @override
  Future<List<AnswerModel>> getAnswers(int questionId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT answer_id, answer_name, question_id, value, lie_value FROM answers JOIN answers_name USING(answer_name_id) WHERE question_id = $questionId");
    var result = data.map((e) => AnswerModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<List<LieResultModel>> getLieResults(int nameId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT id, lie_result, min_value, max_value FROM lie_results WHERE name_id = $nameId");
    var result = data.map((e) => LieResultModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<List<ExercisesModel>> getExercises(int nameId) async {
    var database = await db.database;
    if (nameId == 0) {
      var data = await database.rawQuery("SELECT exercise_id, name_exercise, name_id FROM exercises");
      var result = data.map((e) => ExercisesModel.fromJson(e)).toList();
      return result;
    } else {
      var data = await database.rawQuery("SELECT exercise_id, name_exercise, name_id FROM exercises WHERE name_id = $nameId");
      var result = data.map((e) => ExercisesModel.fromJson(e)).toList();
      return result;
    }
  }

  @override
  Future<List<ImageModel>> getImages(int exerciseId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT images_id, images_path, exercise_id FROM images WHERE exercise_id = $exerciseId");
    var result = data.map((e) => ImageModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<List<ResultModel>> getResults(int nameId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT id, result, min_value, max_value FROM results WHERE checklist_id = $nameId");
    var result = data.map((e) => ResultModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<List<QuestionWithAnswerModel>> getQuestionWithAnswer(int nameId) async {
    var database = await db.database;
    var data = await database.rawQuery("SELECT questions.question_id, question, name_id, question_answer_id, answer_name FROM questions inner join answers ON questions.question_answer_id = answers.answer_id inner join answers_name USING (answer_name_id) WHERE name_id = $nameId");
    var result = data.map((e) => QuestionWithAnswerModel.fromJson(e)).toList();
    return result;
  }
}