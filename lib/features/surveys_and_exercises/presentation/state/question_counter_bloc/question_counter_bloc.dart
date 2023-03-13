import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_counter_event.dart';
// part 'question_counter_state.dart';

class QuestionCounterBloc extends Bloc<QuestionCounterEvent, int> {
  final int initialValue;
  QuestionCounterBloc({required this.initialValue}) : super(initialValue) {
    on<QuestionCounterInc>((event, emit) {
      emit(state + 1);
    });

    on<QuestionCounterDec>((event, emit) {
      if (state > 0) {
        emit(state - 1);
      }
    });
  }
}
