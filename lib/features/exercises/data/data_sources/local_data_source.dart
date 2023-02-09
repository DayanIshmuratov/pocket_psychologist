import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/checklist_model.dart';

abstract class CheckListLocalDataSource {
  Future<List<CheckListModel>> getData();
}

class CheckListLocalDataSourceImpl extends CheckListLocalDataSource {
  final DBProvider db;

  CheckListLocalDataSourceImpl({required this.db});
  @override
  Future<List<CheckListModel>> getData() async {
    var _database = await db.database;
    var _data = await _database.rawQuery('SELECT * FROM checkList');
    List<CheckListModel> _result = _data.map((e) => CheckListModel.fromJson(e)).toList();
    return _result;
  }
}