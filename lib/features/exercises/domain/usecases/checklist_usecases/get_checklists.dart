import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/core/usecases/usecase_without_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';

class GetCheckLists extends UseCaseWithParameters<Future<List<CheckListEntity>>, GetByIdParameters> {
  final CheckListRepository repository;
  GetCheckLists({required this.repository});
  @override
  Future<List<CheckListEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getCheckLists(getByIdParameters.id);
  }
}


//import 'package:pocket_psychologist/core/usecases/usecase_without_parameters.dart';
// import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
// import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
//
// class GetCheckLists extends UseCaseWithoutParameters<Future<List<CheckListEntity>>> {
//   final CheckListRepository repository;
//   GetCheckLists({required this.repository});
//   @override
//   Future<List<CheckListEntity>> call() {
//     return repository.getCheckLists();
//   }
// }