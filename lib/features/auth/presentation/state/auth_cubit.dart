import 'package:bloc/bloc.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as consts;
import 'package:equatable/equatable.dart';
import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';
import 'auth_utils.dart' as utils;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final String _keyAuthState = 'isSigned';
  final String _keyEmail = 'user_email';
  final String _keyName = 'user_name';
  Account account = AccountProvider.get().account;
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

  vkAuth() {
    // account.createOAuth2Session(provider: 'vk');
    logger.info("VK Auth");
  }

  signInWithEmail(String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      await utils.checkAnswersSignIn();
      await _setUserPrefs();
      final userInfo = await _getUserPrefs();
      emit(AuthSigned(userInfo: userInfo));
      }
      on AppwriteException{
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  signUpWithEmail(String name, String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await account.create(
          userId: ID.unique(),
          name: name,
          email: email,
          password: password,
        );
        await utils.checkAnswersSignUp();
        await signInWithEmail(email, password);
      }
      on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  password() async {
    final result = await account.createRecovery(
      email: 'dayanishmuratov11@yandex.ru',
      url: 'https://chowapp.site',
    );
  }

  passwordSecond() async {
    final acc = await account.get();
    Future result = account.updateRecovery(
      userId: acc.$id,
      secret: '[SECRET]',
      password: 'password',
      passwordAgain: 'password',
    );
  }

  _loadAuth() async {
    await _initialisePrefs();
    if (_prefs?.getBool(_keyAuthState) ?? false) {
      emit(AuthUnSigned());
    } else if (await InternetConnectionChecker().hasConnection) {
      try {
        final user = await account.get();
        final userInfo = await _getUserPrefs();
        emit(AuthSigned(userInfo: userInfo));
        //Check is there distinction between data in the localDB and remoteDB
        await utils.checkDistinction(user);
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
    _deleteUserPrefs();
  }

  void _deleteUserPrefs() {
    _prefs?.remove(_keyName);
    _prefs?.remove(_keyEmail);
  }

  Future<void> _setUserPrefs() async {
    final user = await account.get();
    _prefs?.setString(_keyName, user.name);
    _prefs?.setString(_keyEmail, user.email);
  }

  Future<UserInfo> _getUserPrefs() async {
    final name = _prefs?.getString(_keyName) ?? 'Гость';
    final email = _prefs?.getString(_keyEmail) ?? 'aaa@example.com';
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
