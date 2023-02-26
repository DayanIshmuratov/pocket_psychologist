import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_with_answer_usecases/get_questions_with_answer.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class QuestionWithAnswerBloc extends Bloc<BaseEvent, BaseState> {
  final GetQuestionsWithAnswer getQuestion;
  QuestionWithAnswerBloc({required this.getQuestion}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
      final result = await getQuestion(GetByIdParameters(id: event.id ?? 0));
      emit(LoadedListState<QuestionWithAnswerEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
      // print('$s');
      // }
    });
  }
}