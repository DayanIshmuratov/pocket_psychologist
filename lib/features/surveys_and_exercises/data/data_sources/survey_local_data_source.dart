import 'package:flutter/services.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';

import '../data_models/answer_model.dart';
import '../data_models/exercise_model.dart';
import '../data_models/image_model.dart';
import '../data_models/lie_result_model.dart';
import '../data_models/question_model.dart';
import '../data_models/question_with_answer_model.dart';
import '../data_models/result_model.dart';
import '../data_models/survey_model.dart';

abstract class SurveyLocalDataSource<T> {
  Future<List<ResultModel>> getResults(int surveyId);
  Future<List<LieResultModel>> getLieResults(int surveyId);
  Future<List<ExercisesModel>> getExercises(int surveyId);
  Future<List<ImageModel>> getImages(int exerciseId);
  Future<List<SurveyModel>> getSurveys(int surveyId);
  Future<List<QuestionWithAnswerModel>> getQuestionWithAnswer(int surveyId);
  Future<List<QuestionModel>> getQuestions(int surveyId);
  Future<List<AnswerModel>> getAnswers(int questionId);
  Future<void> updateQuestion(QuestionModel model);
}


class SurveyLocalDataSourceSecondImpl implements SurveyLocalDataSource {
  @override
  Future<List<AnswerModel>> getAnswers(int questionId) {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  Future<List<ExercisesModel>> getExercises(int surveyId) {
    // TODO: implement getExercises
    throw UnimplementedError();
  }

  @override
  Future<List<ImageModel>> getImages(int exerciseId) {
    // TODO: implement getImages
    throw UnimplementedError();
  }

  @override
  Future<List<LieResultModel>> getLieResults(int surveyId) {
    // TODO: implement getLieResults
    throw UnimplementedError();
  }

  @override
  Future<List<QuestionWithAnswerModel>> getQuestionWithAnswer(int surveyId) {
    // TODO: implement getQuestionWithAnswer
    throw UnimplementedError();
  }

  @override
  Future<List<QuestionModel>> getQuestions(int surveyId) {
    // TODO: implement getQuestions
    throw UnimplementedError();
  }

  @override
  Future<List<ResultModel>> getResults(int surveyId) {
    // TODO: implement getResults
    throw UnimplementedError();
  }

  @override
  Future<List<SurveyModel>> getSurveys(int surveyId) {
    // TODO: implement getSurveys
    throw UnimplementedError();
  }

  @override
  Future<void> updateQuestion(QuestionModel model) {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }

}


class SurveyLocalDataSourceImpl<T> implements SurveyLocalDataSource {
  final DBProvider db;

  SurveyLocalDataSourceImpl({required this.db});

  @override
  Future<List<SurveyModel>> getSurveys(int surveyId) async {
    var database = await db.database;
    if (surveyId == 0) {
      try {
        var data = await database
            .rawQuery('''SELECT survey_id, survey_name, description, instruction, 
      (SELECT (CASE WHEN SUM(value) IS NULL THEN 0 ELSE SUM(value) END) as sum FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as sum,
    (SELECT (CASE WHEN SUM(lie_value) IS NULL THEN 0 ELSE SUM(lie_value) END) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as lie_sum,
    (SELECT COUNT(question_answer_id) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as done, (SELECT COUNT(question_id) FROM questions WHERE questions.survey_id = surveys.survey_id) as count FROM surveys''');
        var result = data.map((e) => SurveyModel.fromJson(e)).toList();
        return result;
      }
      catch (e) {
        throw CacheException();
      }
    } else {
      try {
        var data = await database
            .rawQuery('''SELECT survey_id, survey_name, description, instruction, 
      (SELECT (CASE WHEN SUM(value) IS NULL THEN 0 ELSE SUM(value) END) as sum FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as sum,
    (SELECT (CASE WHEN SUM(lie_value) IS NULL THEN 0 ELSE SUM(lie_value) END) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as lie_sum,
    (SELECT COUNT(question_answer_id) FROM questions inner join answers ON questions.question_answer_id = answers.answer_id WHERE questions.survey_id = surveys.survey_id AND questions.question_answer_id != 0) as done, (SELECT COUNT(question_id) FROM questions WHERE questions.survey_id = surveys.survey_id) as count FROM surveys WHERE survey_id = $surveyId''');
        var result = data.map((e) => SurveyModel.fromJson(e)).toList();
        return result;
      }
      catch (e) {
        throw CacheException();
      }
    }
  }

  @override
  Future<List<QuestionModel>> getQuestions(int surveyId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT question_id, question, survey_id, question_answer_id FROM questions WHERE survey_id = $surveyId");
      var result = data.map((e) => QuestionModel.fromJson(e)).toList();
      return result;
    }
    catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateQuestion(QuestionModel model) async {
    var database = await db.database;
    try {
      await database.update("questions", model.toMap(),
          where: 'question_id = ?', whereArgs: [model.id]);
    }
    catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<AnswerModel>> getAnswers(int questionId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT answer_id, answer_name, question_id, value, lie_value FROM answers JOIN answers_name USING(answer_name_id) WHERE question_id = $questionId");
      var result = data.map((e) => AnswerModel.fromJson(e)).toList();
      return result;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<LieResultModel>> getLieResults(int surveyId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT id, lie_result, min_value, max_value FROM lie_results WHERE survey_id = $surveyId");
      var result = data.map((e) => LieResultModel.fromJson(e)).toList();
      return result;
    }
    catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ExercisesModel>> getExercises(int surveyId) async {
    var database = await db.database;
    if (surveyId == 0) {
      try {
        var data = await database.rawQuery(
            "SELECT exercise_id, exercise_name, survey_id FROM exercises");
        var result = data.map((e) => ExercisesModel.fromJson(e)).toList();
        return result;
      }
      catch (e) {
        throw CacheException();
      }
    } else {
      try {
        var data = await database.rawQuery(
            "SELECT exercise_id, exercise_name, name_id FROM exercises WHERE survey_id = $surveyId");
        var result = data.map((e) => ExercisesModel.fromJson(e)).toList();
        return result;
      }
      catch (e) {
        throw CacheException();
      }
    }
  }

  @override
  Future<List<ImageModel>> getImages(int exerciseId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT images_id, images_path, exercise_id FROM images WHERE exercise_id = $exerciseId");
      var result = data.map((e) => ImageModel.fromJson(e)).toList();
      return result;
    }
    catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ResultModel>> getResults(int surveyId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT id, result, min_value, max_value FROM results WHERE survey_id = $surveyId");
      var result = data.map((e) => ResultModel.fromJson(e)).toList();
      return result;
    }
    catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<QuestionWithAnswerModel>> getQuestionWithAnswer(
      int surveyId) async {
    var database = await db.database;
    try {
      var data = await database.rawQuery(
          "SELECT questions.question_id, question, survey_id, question_answer_id, answer_name "
              "FROM questions inner join answers ON questions.question_answer_id = answers.answer_id inner join answers_name "
              "USING (answer_name_id) WHERE survey_id = $surveyId");
      var result = data.map((e) => QuestionWithAnswerModel.fromJson(e)).toList();
      return result;
    }
    catch (e) {
      throw CacheException();
    }
  }
}


