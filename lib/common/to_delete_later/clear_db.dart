import 'package:pocket_psychologist/core/db/database.dart';

class ResetDB {
  static final db = DBProvider.db.database;
  void reset() {
    db.then((value) => value.rawUpdate("Update questions set question_answer_id = 0"));
  }
}