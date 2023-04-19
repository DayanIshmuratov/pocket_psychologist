import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final String _keyAuthState = 'isSigned';
  final String _keyEmail = 'user_email';
  final String _keyName = 'user_name';
  late Account account = AccountProvider.get().account;
  SharedPreferences? _prefs;

  AuthCubit() : super(AuthUnSigned()) {
    _loadAuth();
  }

  _initialisePrefs() async {
    // SharedPreferences.setMockInitialValues({});
    _prefs ??= await SharedPreferences.getInstance();
    // _prefs?.setString(key, 'purple');
  }

  _savePrefs(bool isSigned) {
    _prefs?.setBool(_keyAuthState, isSigned);
  }
  googleAuth() {
    account.createOAuth2Session(provider: 'google');
  }
  signInWithEmail(String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      final session = await account.createEmailSession(
        email: email,
        password: password,
      );
      await _setUserPrefs();
      final userInfo = await _getUserPrefs();
      emit(AuthSigned(userInfo: userInfo));
    } else {
      throw NetworkException();
    }
  }

  signUpWithEmail(String name, String email, String password) async {
    final user = await account.create(
      userId: ID.unique(),
      name: name,
      email: email,
      password: password,
    );
    await signInWithEmail(email, password);
  }

  _loadAuth() async {
    await _initialisePrefs();
    if (_prefs?.getBool(_keyAuthState) ?? false) {
      emit(AuthUnSigned());
    } else if (await InternetConnectionChecker().hasConnection) {
      try {
        await account.get();
        final userInfo = await _getUserPrefs();
        emit(AuthSigned(userInfo: userInfo));
        //Check is there distinction between data in the localDB and remoteDB
      } catch (e, s) {
        logger.severe(e, s);
      }
    } else {
      final userInfo = await _getUserPrefs();
      emit(AuthSigned(userInfo: userInfo));
    }
  }

  logOut() async {
    emit(AuthUnSigned());
    _savePrefs(false);
  }

  Future<void> _setUserPrefs() async {
    final user = await account.get();
    _prefs?.setString(_keyName, user.name);
    _prefs?.setString(_keyEmail, user.email);
  }

  Future<UserInfo> _getUserPrefs() async {
    final name = await _prefs?.getString(_keyName) ?? 'Гость';
    final email = await _prefs?.getString(_keyEmail) ?? 'aaa@example.com';
    return UserInfo(
      name: name,
      email: email,
    );
  }
}

class UserInfo {
  final String name;
  final String email;

  UserInfo({required this.name, required this.email});
}
