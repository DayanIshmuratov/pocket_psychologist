import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:appwrite/appwrite.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Client client;
  AuthCubit(this.client) : super(AuthInSigned());

  auth(String email, String password) async {
    Account account = Account(client);
    final user = await account.createEmailSession(email: email, password: password);
    // final session = await account.createPhoneSession(
    //     userId: ID.unique(),
    //     phone: email
    // );
    emit(AuthSigned(account));
    // account.create(
    //     userId: ID.unique(),
    //     email: 'me@appwrite.io',
    //     password: 'password',
    //     name: 'My Name'
    // );

  }

  logOut() async {
    Account account = Account(client);
    account.deleteSession(sessionId: 'current');
    emit(AuthInSigned());
  }
}
