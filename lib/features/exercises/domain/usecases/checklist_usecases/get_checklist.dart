import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class GetCheckLists {
  final CheckListRepository repository;
  GetCheckLists({required this.repository});

  Future<List<CheckListEntity>> call() {
    return repository.getCheckLists();
  }
}