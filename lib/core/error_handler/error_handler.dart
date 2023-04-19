import 'package:flutter/material.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = _recordFlutterError;
    logger.info('ErrorHandler initialized');
    // print('ErrorHandler initialized');
  }


  static void recordError(Object error, StackTrace stackTrace) {
    // print(error);
    // print(stackTrace);
    logger.info('recordError');
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    // print(error.toStringShort());
    // print(error.exception);
    // print(error.stack);
    logger.info('_recordFlutterError');
    logger.severe(error.toStringShort(), error.exception, error.stack);
  }

  const ErrorHandler._();
}