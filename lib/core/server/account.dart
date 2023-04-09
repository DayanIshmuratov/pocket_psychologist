import 'package:appwrite/appwrite.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';

class AccountProvider {

  Account account = Account(AppWriteProvider().client);

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
    final session = await account.createEmailSession(
        email: email,
        password: password,
    );
  }

  logOut() async {
    final session = await account.deleteSession(sessionId: 'current');
  }

}