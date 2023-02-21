import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

abstract class CheckListRepository {
  Future<List<CheckListEntity>> getCheckLists();
  Future<QuestionEntity> getQuestion(int id, int questionId);
  Future<void> updateAnswer(AnswerEntity entity);
  Future<void> updateCheckList(CheckListEntity entity);
  // Future<T> getEntity(int id, String tableName);
  // Future<void> updateById(T entity, String tableName, int id);
  // Future<List<QuestionEntity>> getQuestions(int nameId);
  // Future<List<ExerciseEntity>> getExercises(int nameId);
  // Future<List<ImageEntity>> getImages(int exercisesId);
}