
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:pocket_psychologist/features/auth/domain/entity/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';
import 'auth_utils.dart' as utils;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final String _keyAuthState = 'isSigned';
  final String _keyEmail = 'user_email';
  final String _keyName = 'user_name';
  final String _keyId = 'user_id';
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

  _saveAuthState(bool isSigned) {
    _prefs?.setBool(_keyAuthState, isSigned);
  }

  googleAuth(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await account.createOAuth2Session(provider: 'google');
        final models.Account user = await AccountProvider.get().account.get();
        final userData = UserData.fromMap(user);
        utils.checkAnswers(userData, context);
        await _setUserPrefs(userData);
        emit(AuthSigned(userData: userData));
      } on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  vkAuth() {
    // account.createOAuth2Session(provider: 'vk');
    logger.info("VK Auth");
  }

  signInWithEmail(BuildContext context, String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      final models.Account user = await AccountProvider.get().account.get();
      final userData = UserData.fromMap(user);
      await utils.checkAnswers(userData, context);
      await _setUserPrefs(userData);
      // final userData = await _getUserPrefs();
      emit(AuthSigned(userData: userData));
      }
      on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  signUpWithEmail(BuildContext context, String name, String email, String password) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final user = await account.create(
          userId: ID.unique(),
          name: name,
          email: email,
          password: password,
        );
        await account.createEmailSession(
          email: email,
          password: password,
        );
        final userData = UserData.fromMap(user);
        await utils.checkAnswers(userData, context);
        await _setUserPrefs(userData);
        emit(AuthSigned(userData: userData));
      }
      on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  // passwordSecond() async {
  //   final acc = await account.get();
  //   Future result = account.updateRecovery(
  //     userId: acc.$id,
  //     secret: '[SECRET]',
  //     password: 'password',
  //     passwordAgain: 'password',
  //   );
  // }

  passwordRecovery(String email) async {
    final token = await account.createRecovery(
      email: email,
      url: 'https://chowapp.site/recovery/recovery.html',
    );
    logger.info(token);
    logger.info(token.toMap());
    logger.info(token.secret);
  }

  updateName(String name) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await account.updateName(name: name);
      } on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  _loadAuth() async {
    await _initialisePrefs();
    if (_prefs?.getBool(_keyAuthState) ?? false) {
      emit(AuthUnSigned());
    } else if (await InternetConnectionChecker().hasConnection) {
      try {
        final user = await account.get();
        final userData = UserData.fromMap(user);
        // final userInfo = await _getUserPrefs();
        emit(AuthSigned(userData: userData));
        //Check is there distinction between data in the localDB and remoteDB
        await utils.checkDistinction(userData);
      } catch (e, s) {
        logger.severe(e, s);
      }
    } else {
      final userData = await _getUserPrefs();
      emit(AuthSigned(userData: userData));
    }
  }

  logOut() async {
    await account.deleteSession(sessionId: 'current');
    emit(AuthUnSigned());
    _saveAuthState(false);
    _deleteUserPrefs();
  }

  void _deleteUserPrefs() {
    _prefs?.remove(_keyName);
    _prefs?.remove(_keyEmail);
  }

  Future<void> _setUserPrefs(UserData userData) async {
    _prefs?.setString(_keyId, userData.id);
    _prefs?.setString(_keyName, userData.name);
    _prefs?.setString(_keyEmail, userData.email);
  }

  Future<UserData> _getUserPrefs() async {
    final name = _prefs?.getString(_keyName) ?? 'Гость';
    final email = _prefs?.getString(_keyEmail) ?? 'aaa@example.com';
    final id = _prefs?.getString(_keyId) ?? '';
    return UserData(
      name: name,
      email: email,
      id: id,
      registration: null,
      status: null,
      emailVerification: null,
      passwordUpdate: null,
      prefs: null,
    );
  }



}
