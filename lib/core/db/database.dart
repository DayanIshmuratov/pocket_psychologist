import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static late Database _database;

  Future<Database> get database async {
    _database = await _initialDB();
    return _database;
  }

  Future<Database> _initialDB() async {
    var databasesPath = await getDatabasesPath();
    var path = '$databasesPath/sqlite.db';
    bool exist = await databaseExists(path);
    if (!exist) {
      ByteData data = await rootBundle.load('assets/databases/sqlite.db');
      List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    var db = await openDatabase(path);
    return db;
    }

  static Future<void> resetDB()  async {
    await db.database.then((value) => value.rawUpdate("Update questions set question_answer_id = 0"));
  }
  }
