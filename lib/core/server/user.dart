import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:pocket_psychologist/core/server/appwrite_server.dart';

import 'appwrite.dart';

class AppWriteUserProvider {
  static AppWriteUserProvider instance = AppWriteUserProvider._();
  late Users users;

  factory AppWriteUserProvider() {
    return instance;
  }

  AppWriteUserProvider._() {
    users = Users(AppWriteServerProvider.instance.client);
  }
}