import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';

import '../exceptions/exceptions.dart';

class AccountProvider {
  static AccountProvider? instance;
  late Account account;

  AccountProvider._internal() {
     account = Account(AppWriteProvider().client);
  }

  static AccountProvider get() {
    return instance ??= AccountProvider._internal();
  }

}