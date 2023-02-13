import 'package:pocket_psychologist/features/exercises/data/data_sources/checklist_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/question_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class CheckListRepositoryImpl extends CheckListRepository{
  final CheckListLocalDataSource checkListLocalDataSource;
  // final QuestionLocalDataSource questionLocalDataSource;

  CheckListRepositoryImpl({required this.checkListLocalDataSource});
  @override
  Future<List<CheckListEntity>> getCheckLists() {
    try {
      final result = checkListLocalDataSource.getData();
      return result;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ExerciseEntity>> getExercises(int nameId) {
    // TODO: implement getExercises
    throw UnimplementedError();
  }

  @override
  Future<List<ImageEntity>> getImages(int exercisesId) {
    // TODO: implement getImages
    throw UnimplementedError();
  }

  // @override
  // Future<List<QuestionEntity>> getQuestions(int nameId) {
  //   final result = questionLocalDataSource.getQuestions(nameId);
  //   return result;
  // }
}