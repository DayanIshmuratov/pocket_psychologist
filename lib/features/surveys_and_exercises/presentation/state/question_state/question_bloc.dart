import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class QuestionCubit extends Cubit<BaseState> {
  final GetQuestions getQuestion;
  final UpdateQuestion updateQuestion;
  QuestionCubit({required this.getQuestion, required this.updateQuestion}) : super(EmptyState());
  // {
    // on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
    //   emit(LoadingState());
    //   try {
    //     final result = await getQuestion(GetByIdParameters(id: event.id ?? 0));
    //     emit(LoadedListState<QuestionEntity>(entities: result));
    //   }
    //   catch (e) {
    //     emit(ErrorState(text: e.toString()));
    //   }
    // });
    // on<UpdateEvent<QuestionEntity>>((UpdateEvent<QuestionEntity> event, Emitter<BaseState> emit) async {
    // });
  // }

  void loadData(int? id) async {
    emit(LoadingState());
    try {
      final result = await getQuestion(GetByIdParameters(id: id ?? 0));
      emit(LoadedListState<QuestionEntity>(entities: result));
    }
    catch (e) {
      emit(ErrorState(text: e.toString()));
    }
  }

  void updateData(QuestionEntity entity) async {
    await updateQuestion(UpdateTableParameters(entity: entity));
  }
}