import '../entities/answer_entity.dart';
import '../entities/exercise_entity.dart';
import '../entities/image_entity.dart';
import '../entities/lie_results_entity.dart';
import '../entities/question_entity.dart';
import '../entities/question_with_answer_entity.dart';
import '../entities/result_entity.dart';
import '../entities/survey_entity.dart';

abstract class SurveyRepository {
  Future<List<QuestionWithAnswerEntity>> getQuestionsWithAnswers(int id);
  Future<List<SurveyEntity>> getSurveys(int id);
  Future<List<QuestionEntity>> getQuestions(int id);
  Future<List<AnswerEntity>> getAnswers(int id);
  Future<List<ResultEntity>> getResults(int id);
  Future<List<LieResultEntity>> getLieResults(int id);
  Future<List<ExercisesEntity>> getExercises(int id);
  Future<List<ImageEntity>> getImages(int id);
  Future<void> updateQuestion(QuestionEntity entity);
}