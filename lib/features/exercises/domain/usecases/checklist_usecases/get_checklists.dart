import 'package:pocket_psychologist/core/usecases/usecase_without_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class GetCheckLists extends UseCaseWithoutParameters<Future<List<CheckListEntity>>> {
  final CheckListRepository repository;
  GetCheckLists({required this.repository});
  @override
  Future<List<CheckListEntity>> call() {
    return repository.getCheckLists();
  }
}