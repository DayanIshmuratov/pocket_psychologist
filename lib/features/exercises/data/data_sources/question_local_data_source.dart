import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';

abstract class QuestionLocalDataSource {
  Future<List<QuestionModel>> getQuestions(int nameId);
}

class QuestionLocalDataSourceImpl extends QuestionLocalDataSource {
  final DBProvider db;

  QuestionLocalDataSourceImpl({required this.db});

  @override
  Future<List<QuestionModel>> getQuestions(int nameId) async {
    var _database = await db.database;
    var _data = await _database.rawQuery('SELECT * FROM questions WHERE name_id = $nameId');
    List<QuestionModel> _result = _data.map((e) => QuestionModel.fromJson(e)).toList();
    return _result;
  }
}