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

  static get() {
    return instance ??= AccountProvider._internal();
  }

  signUp(String email, String password, String name) async {
    final user = await account.create(
      userId: ID.unique(),
      name: name,
      email: email,
      password: password,
    );
    await signIn(email, password);
  }

  signIn(String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      final session = await account.createEmailSession(
        email: email,
        password: password,
      );

    } else {
      throw NetworkException();
    }
  }

  logOut() async {
    final session = await account.deleteSession(sessionId: 'current');
  }

}