import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';

abstract class CheckListRepository {
  Future<List<QuestionWithAnswerEntity>> getQuestionsWithAnswers(int id);
  Future<List<CheckListEntity>> getCheckLists(int id);
  Future<List<QuestionEntity>> getQuestions(int id);
  Future<List<AnswerEntity>> getAnswers(int id);
  Future<List<ResultEntity>> getResults(int id);
  Future<List<LieResultEntity>> getLieResults(int id);
  Future<List<ExercisesEntity>> getExercises(int id);
  Future<List<ImageEntity>> getImages(int id);
  // Future<void> updateAnswer(AnswerEntity entity);
  Future<void> updateQuestion(QuestionEntity entity);
  // Future<void> updateCheckList(CheckListEntity entity);
  // Future<T> getEntity(int id, String tableName);
  // Future<void> updateById(T entity, String tableName, int id);
  // Future<List<QuestionEntity>> getQuestions(int nameId);
  // Future<List<ExerciseEntity>> getExercises(int nameId);
  // Future<List<ImageEntity>> getImages(int exercisesId);
}