import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  Future<Database> get database async {
    //if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = '$databasesPath/sqlite.db';
    bool exist = await databaseExists(path);
    if (!exist) {
      print("Creating new copy from asset");
      //
      // try {
      //   await Directory(path).create(recursive: true);
      // } catch(_) {print(path);}
      ByteData data = await rootBundle.load('assets/databases/sqlite.db');
      List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing db");
    }
    var db = await openDatabase(path);
    return db;
    var result = await db.rawQuery('SELECT * FROM demo');
    // List<Model> models = result.map((element) => Model.fromJson(element))
    //     .toList();
    // for (Model i in models) {
    //   log('${i.id} - ${i.name}');
    }
  }
