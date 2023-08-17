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

  AuthCubit() : super(AuthLoading()) {
    _loadAuth();
  }

  _loadAuth() async {
    await _initialisePrefs();
    bool? authState = _prefs?.getBool(_keyAuthState);
    if (authState == null || authState == false) {
      emit(AuthUnSigned());
    } else if (await InternetConnectionChecker().hasConnection) {
      try {
        final user = await account.get();
        final userData = UserData.fromMap(user);
        emit(AuthSigned(userData: userData));
        await utils.checkDistinction(userData);
      } catch (e, s) {
        logger.severe(e, s);
      }
    } else {
      final userData = await _getUserPrefs();
      emit(AuthSigned(userData: userData));
    }
  }



  _initialisePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _saveAuthState(bool isSigned) {
    _prefs?.setBool(_keyAuthState, isSigned);
  }

  googleAuth(BuildContext context) async {
    checkConnection(() async {
      await account.createOAuth2Session(provider: 'google');
      final models.Account user = await AccountProvider.get().account.get();
      final userData = UserData.fromMap(user);
      await utils.checkAnswers(userData, context);
      await _setUserPrefs(userData);
      _saveAuthState(true);
      emit(AuthSigned(userData: userData));
    });
  }

  vkAuth() {
    logger.info("VK Auth");
  }

  signInWithEmail(BuildContext context, String email, String password) async {
    checkConnection(() async {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      final models.Account user = await AccountProvider.get().account.get();
      final userData = UserData.fromMap(user);
      await utils.checkAnswers(userData, context);
      await _setUserPrefs(userData);
      _saveAuthState(true);
      emit(AuthSigned(userData: userData));
    });
  }

  signUpWithEmail(BuildContext context, String name, String email, String password) async {
    checkConnection(() async {
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
      await createEmailVerification();
      final userData = UserData.fromMap(user);
      await utils.checkAnswers(userData, context);
      await _setUserPrefs(userData);
      _saveAuthState(true);
      emit(AuthSigned(userData: userData));
    });
  }

  refresh() async {
    emit(AuthLoading());
    final user = await account.get();
    final userData = UserData.fromMap(user);
    emit(AuthSigned(userData: userData));
  }

  passwordRecovery(String email) async {
    final token = await account.createRecovery(
      email: email,
      url: 'https://recovery.chowapp.site',
    );
    logger.info(token);
    logger.info(token.toMap());
    logger.info(token.secret);
  }

  updateName(String name) async {
    checkConnection(() async {
      await account.updateName(name: name);
    });
  }

  updatePassword(String oldPassword, String newPassword) {
    checkConnection(() async {
      await account.updatePassword(password: newPassword, oldPassword: oldPassword);
    });
  }

  checkConnection (Function request) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        request;
      } on AppwriteException {
        rethrow;
      }
    } else {
      throw NetworkException();
    }
  }

  updateEmail(String email, String password) async{
    checkConnection(() async {
      await account.updateEmail(email: email, password: password);
      await createEmailVerification();
    });
  }

  createEmailVerification() async {
    await account.createVerification(url: 'https://verify.chowapp.site');
  }


  logOut() async {
    await account.deleteSession(sessionId: 'current');
    emit(AuthUnSigned());
    _saveAuthState(false);
    _deleteUserPrefs();
  }

  void _deleteUserPrefs() {
    _prefs?.remove(_keyId);
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
