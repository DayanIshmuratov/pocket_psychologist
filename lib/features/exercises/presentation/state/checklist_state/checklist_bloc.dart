import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/get_checklists.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_state.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/usecases/get_entity_lists.dart';

class CheckListBloc extends Bloc<BaseEvent, BaseState> {
  final GetCheckLists getCheckLists;
  final UpdateCheckList updateCheckList;
  CheckListBloc({required this.updateCheckList, required this.getCheckLists}) : super(EmptyState()) {
  on<LoadEvent>((LoadEvent event, Emitter<BaseState> emit) async {
    emit(LoadingState());
    // try {
      final result = await getCheckLists();
      emit(LoadedListState<CheckListEntity>(entities: result));
    // }
    // catch (e) {
    //   emit(ErrorState(text: e.toString()));
    //   // print('$s');
    // }
  }
  );
  on<UpdateEvent<CheckListEntity>>((UpdateEvent<CheckListEntity> event, Emitter<BaseState> emit)  async {
       await updateCheckList(event.entity);
  });
  }

}