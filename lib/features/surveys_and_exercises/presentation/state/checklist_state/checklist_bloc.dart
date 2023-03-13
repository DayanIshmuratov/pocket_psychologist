import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/checklist_usecases/get_surveys.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_state.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/usecases/get_entity_lists.dart';

class CheckListBloc extends Bloc<BaseEvent, BaseState> {
  final GetCheckLists getCheckLists;
  CheckListBloc({required this.getCheckLists}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
      final result = await getCheckLists(GetByIdParameters(id: 0));
      emit(LoadedListState<CheckListEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
      //   // print('$s');
      // }
    }
    );
    on<LoadEvent>((LoadEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      final result = await getCheckLists(GetByIdParameters(id: event.id));
      emit(LoadedState<CheckListEntity>(entity: result[0]));
    });
  }

}