import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logger/logger.dart';

class MainBlocObserver extends BlocObserver {

  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      logger.severe(bloc);
    }
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      logger.severe(bloc, change);
    }
    super.onChange(bloc, change);
  }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      logger.severe(bloc, error, stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }
}