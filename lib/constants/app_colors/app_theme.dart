
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends Cubit<AppThemeState> {
  final String key = 'app_theme';
  // AppThemeState appThemeState = PurpleAppThemeState();
  SharedPreferences? _prefs;
  AppTheme() : super(PurpleAppThemeState()) {
     _loadPrefs();
  }

  _initialisePrefs() async {
    // SharedPreferences.setMockInitialValues({});
    _prefs ??= await SharedPreferences.getInstance();
    // _prefs?.setString(key, 'purple');
  }

  _loadPrefs() async {
    await _initialisePrefs();
    final themeName = _prefs?.getString(key);
    Timer(Duration(milliseconds: 100), () {});
    emit(_fromThemeToAppThemeState(themeName ?? 'purple'));
  }

  _savePrefs(String themeName) {
    // await _initialisePrefs();
    _prefs?.setString(key, themeName);
  }

  changeToGreen() {
    _savePrefs('green');
    emit(GreenAppThemeState());
  }

  changeToPurple() {
    _savePrefs('purple');
    emit(PurpleAppThemeState());
  }

  AppThemeState _fromThemeToAppThemeState (String themeName) {
    switch (themeName) {
      case "purple" : return PurpleAppThemeState();
      case "green" : return GreenAppThemeState();
    }
    return PurpleAppThemeState();
  }
}

abstract class AppThemeState {
  late Color mainColor;
  late Color secondaryColor;
}

class PurpleAppThemeState extends AppThemeState {
   final mainColor = Colors.indigo;
   final secondaryColor = Colors.indigo.shade300;
}

class GreenAppThemeState extends AppThemeState {
   final mainColor = Colors.green;
   final secondaryColor = Colors.green.shade300;
}


// //
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppTheme extends Cubit<AppThemeState> {
//   final String themeNameKey = 'app_theme';
//   final String indexKey = 'index';
//   int index = 0;
//   // AppThemeState appThemeState = PurpleAppThemeState();
//   SharedPreferences? _prefs;
//   AppTheme() : super(PurpleAppThemeState()) {
//     _loadPrefs();
//   }
//
//   _initialisePrefs() async {
//     // SharedPreferences.setMockInitialValues({});
//     _prefs ??= await SharedPreferences.getInstance();
//     // _prefs?.setString(key, 'purple');
//   }
//
//   _loadPrefs() async {
//     await _initialisePrefs();
//     final themeName = _prefs?.getString(themeNameKey);
//     index = _prefs?.getInt(indexKey) ?? 0;
//     Timer(Duration(milliseconds: 100), () {});
//     emit(_fromThemeToAppThemeState(themeName ?? 'purple'));
//   }
//
//   _savePrefs(String themeName, int index) {
//     // await _initialisePrefs();
//     _prefs?.setString(themeNameKey, themeName);
//     _prefs?.setInt(indexKey, index);
//   }
//
//   changeToGreen() {
//     _savePrefs('green', 1);
//     emit(GreenAppThemeState());
//   }
//
//   changeToPurple() {
//     _savePrefs('purple', 0);
//     emit(PurpleAppThemeState());
//   }
//
//   AppThemeState _fromThemeToAppThemeState (String themeName) {
//     switch (themeName) {
//       case "purple" : return PurpleAppThemeState();
//       case "green" : return GreenAppThemeState();
//     }
//     return PurpleAppThemeState();
//   }
// }
//
// abstract class AppThemeState {
//   late Color mainColor;
//   late Color secondaryColor;
// }
//
// class PurpleAppThemeState extends AppThemeState {
//   final mainColor = Colors.indigo;
//   final secondaryColor = Colors.indigo.shade300;
// }
//
// class GreenAppThemeState extends AppThemeState {
//   final mainColor = Colors.green;
//   final secondaryColor = Colors.green.shade300;
// }
