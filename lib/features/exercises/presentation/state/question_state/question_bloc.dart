import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class QuestionBloc extends Bloc<BaseEvent, BaseState> {
  final GetQuestions getQuestion;
  final UpdateQuestion updateQuestion;
  QuestionBloc({required this.getQuestion, required this.updateQuestion}) : super(EmptyState()) {
    on<LoadEvent>((LoadEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
        final result = await getQuestion(GetByIdParameters(id: event.id ?? 0));
        emit(LoadedListState<QuestionEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
        // print('$s');
      // }
    });
    on<UpdateEvent<QuestionEntity>>((UpdateEvent<QuestionEntity> event, Emitter<BaseState> emit) async {
      await updateQuestion(UpdateTableParameters(entity: event.entity));
    });
  }
}