import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class UpdateCheckList {
  CheckListRepository repository;
  UpdateCheckList({required this.repository});
  Future<void> call(CheckListEntity checkListEntity) {
    return repository.updateCheckList(checkListEntity);
  }
}