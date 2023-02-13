import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_state.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/usecases/checklist_usecases/get_checklist.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  final GetCheckLists getCheckLists;
  CheckListBloc({required this.getCheckLists}) : super(CheckListStateEmpty()) {
  on<OnCheckListEvent>((OnCheckListEvent event, Emitter<CheckListState> emit) async {
    emit(CheckListStateLoading());
    try {
      final result = await getCheckLists();
      emit(CheckListStateLoaded<List<CheckListEntity>>(result)); }
    catch (e) {
      emit(CheckListStateError(e.toString()));
      // print('$s');
    }
  }
  );
  }

}