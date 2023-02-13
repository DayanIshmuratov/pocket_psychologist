import 'package:flutter/services.dart';
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
    // var _database = await rootBundle('assets/databases/sqlite.db');
    // var _data = _database.
    var _database = await db.database;
    var _data = await _database.rawQuery("SELECT name_id, checklist_name, description, GROUP_CONCAT(question_id, '@') as question_id, GROUP_CONCAT(name_question, '@') as name_question, GROUP_CONCAT(answers, '@') as answers FROM check_lists INNER JOIN questions USING(name_id) GROUP BY name_id");
    List<CheckListModel> _result = _data.map((e) => CheckListModel.fromJson(e)).toList();
    return _result;
  }
}