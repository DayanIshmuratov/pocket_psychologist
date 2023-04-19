import 'package:appwrite/appwrite.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';

class AppWriteDBProvider {
  static AppWriteDBProvider instance = AppWriteDBProvider._();
  late Databases db;

  factory AppWriteDBProvider() {
    return instance;
  }

  AppWriteDBProvider._() {
    db = Databases(AppWriteProvider().client);
  }
}