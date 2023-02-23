import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class GetQuestions extends UseCaseWithParameters<Future<List<QuestionEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetQuestions({required this.repository});
  Future<List<QuestionEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getQuestions(getByIdParameters.id);
  }
}

class GetByIdParameters {
  final int id;
  GetByIdParameters({required this.id});
}