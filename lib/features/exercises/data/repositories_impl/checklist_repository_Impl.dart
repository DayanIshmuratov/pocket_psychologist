import 'package:pocket_psychologist/features/exercises/data/data_sources/local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class CheckListRepositoryImpl extends CheckListRepository{
  final CheckListLocalDataSource checkListLocalDataSource;

  CheckListRepositoryImpl({required this.checkListLocalDataSource});
  @override
  Future<List<CheckListEntity>> getCheckLists() {
    return checkListLocalDataSource.getData();
  }
}