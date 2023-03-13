import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/answer_usecases/get_answers.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:sqflite/sqlite_api.dart';
// import 'package:sqflite/sqflite.dart';

class AnswerBloc extends Bloc<BaseEvent, BaseState> {
  // final UpdateAnswer updateAnswer;
  final GetAnswers getAnswers;
  AnswerBloc({required this.getAnswers}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      try {
        var result = await getAnswers(GetByIdParameters(id: event.id ?? 0));
        emit(LoadedListState<AnswerEntity>(entities: result));
      } on CacheException catch (e, s) {
        logger.severe(e, e, s);
        emit(ErrorState(text: e.message));
      }
    }
    );

  }
}