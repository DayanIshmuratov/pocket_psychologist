import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class QuestionBloc extends Bloc<BaseEvent, BaseState> {
  final GetQuestion getQuestion;
  QuestionBloc({required this.getQuestion}) : super(EmptyState()) {
    on<LoadEvent>((LoadEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
        final result = await getQuestion(event.id ?? 1, event.secondId ?? 1);
        emit(LoadedState<QuestionEntity>(entity: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
        // print('$s');
      // }
    });
  }
}