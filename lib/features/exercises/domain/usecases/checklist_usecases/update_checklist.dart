import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class UpdateCheckList {
  final CheckListRepository checkListRepository;
  UpdateCheckList({required this.checkListRepository});

  Future<void> call(CheckListEntity entity) async {
    await checkListRepository.updateCheckLists(entity);
  }

}