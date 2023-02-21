import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/checklist_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/checklist_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/question_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class CheckListRepositoryImpl<T extends BaseEntity> extends CheckListRepository{
  final CheckListLocalDataSource checkListLocalDataSource;
  // final QuestionLocalDataSource questionLocalDataSource;

  CheckListRepositoryImpl({required this.checkListLocalDataSource});

  @override
  Future<List<CheckListEntity>> getCheckLists() async {
    return await checkListLocalDataSource.getCheckLists();
  }

  @override
  Future<QuestionEntity> getQuestion(int id, int questionId) async {
    return await checkListLocalDataSource.getQuestion(id, questionId);
  }

  @override
  Future<void> updateAnswer(AnswerEntity entity) async {
    return await checkListLocalDataSource.updateAnswer(entity as AnswerModel);
  }

  @override
  Future<void> updateCheckList(CheckListEntity entity) async {
    return await checkListLocalDataSource.updateCheckList(entity as CheckListModel);
  }

}