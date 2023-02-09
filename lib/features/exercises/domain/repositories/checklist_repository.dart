import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';

abstract class CheckListRepository {
  Future<List<CheckListEntity>> getCheckLists();
}