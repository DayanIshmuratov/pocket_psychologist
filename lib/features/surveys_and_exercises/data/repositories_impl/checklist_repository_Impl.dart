
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/data/data_sources/survey_local_data_source.dart';

import '../../../../core/logger/logger.dart';
import '../../domain/entities/answer_entity.dart';
import '../../domain/entities/exercise_entity.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/entities/lie_results_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/entities/question_with_answer_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/entities/survey_entity.dart';
import '../../domain/repositories/survey_repository.dart';
import '../data_models/question_model.dart';
import '../data_sources/remote_data_source.dart';

class SurveyRepositoryImpl<T extends BaseEntity> implements SurveyRepository{
  final SurveyLocalDataSource surveyLocalDataSource;
  final SurveyRemoteDataSource surveyRemoteDataSource;

  SurveyRepositoryImpl({required this.surveyLocalDataSource, required this.surveyRemoteDataSource});

  @override
  Future<List<SurveyEntity>> getSurveys(int id) async {
    return await surveyLocalDataSource.getSurveys(id);
  }

  @override
  Future<List<QuestionEntity>> getQuestions(int id) async {
    return await surveyLocalDataSource.getQuestions(id);
  }


  @override
  Future<void> updateQuestion(QuestionEntity entity) async {
    try {
      await AccountProvider.get().account.get();
      await surveyRemoteDataSource.saveData(entity as QuestionModel);
    } catch (e) {
      logger.severe(e);
    }
    finally {
      return await surveyLocalDataSource.updateQuestion(entity as QuestionModel);
    }
  }

  @override
  Future<List<AnswerEntity>> getAnswers(int questionId) async {
    return await surveyLocalDataSource.getAnswers(questionId);
  }

  @override
  Future<List<ExercisesEntity>> getExercises(int nameId) async {
    return await surveyLocalDataSource.getExercises(nameId);
  }

  @override
  Future<List<ImageEntity>> getImages(int exerciseId) async {
    return await surveyLocalDataSource.getImages(exerciseId);
  }

  @override
  Future<List<LieResultEntity>> getLieResults(int nameId) async {
    return await surveyLocalDataSource.getLieResults(nameId);
  }

  @override
  Future<List<ResultEntity>> getResults(int nameId) async {
    return await surveyLocalDataSource.getResults(nameId);
  }

  @override
  Future<List<QuestionWithAnswerEntity>> getQuestionsWithAnswers(int id) async {
    return await surveyLocalDataSource.getQuestionWithAnswer(id);
  }
}