import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/answer_usecases/get_answers.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';

class AnswerBloc extends Bloc<BaseEvent, BaseState> {
  // final UpdateAnswer updateAnswer;
  final GetAnswers getAnswers;
  AnswerBloc({required this.getAnswers}) : super(EmptyState()) {
    on<LoadEvent>((LoadEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      var result = await getAnswers(GetByIdParameters(id: event.id ?? 0));
      emit(LoadedListState<AnswerEntity>(entities: result));

    }
    );

  }
}