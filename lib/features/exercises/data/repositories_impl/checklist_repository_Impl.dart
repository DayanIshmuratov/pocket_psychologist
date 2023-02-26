import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/checklist_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/checklist_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/question_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class CheckListRepositoryImpl<T extends BaseEntity> extends CheckListRepository{
  final CheckListLocalDataSource checkListLocalDataSource;
  // final QuestionLocalDataSource questionLocalDataSource;

  CheckListRepositoryImpl({required this.checkListLocalDataSource});

  @override
  Future<List<CheckListEntity>> getCheckLists(int id) async {
    return await checkListLocalDataSource.getCheckLists(id);
  }

  @override
  Future<List<QuestionEntity>> getQuestions(int id) async {
    return await checkListLocalDataSource.getQuestions(id);
  }


  @override
  Future<void> updateQuestion(QuestionEntity entity) async {
    return await checkListLocalDataSource.updateQuestion(entity as QuestionModel);
  }

  @override
  Future<List<AnswerEntity>> getAnswers(int questionId) async {
    return await checkListLocalDataSource.getAnswers(questionId);
  }

  @override
  Future<List<ExercisesEntity>> getExercises(int nameId) async {
    return await checkListLocalDataSource.getExercises(nameId);
  }

  @override
  Future<List<ImageEntity>> getImages(int exerciseId) async {
    return await checkListLocalDataSource.getImages(exerciseId);
  }

  @override
  Future<List<LieResultEntity>> getLieResults(int nameId) async {
    return await checkListLocalDataSource.getLieResults(nameId);
  }

  @override
  Future<List<ResultEntity>> getResults(int nameId) async {
    return await checkListLocalDataSource.getResults(nameId);
  }

  @override
  Future<List<QuestionWithAnswerEntity>> getQuestionsWithAnswers(int id) async {
    return await checkListLocalDataSource.getQuestionWithAnswer(id);
  }
}