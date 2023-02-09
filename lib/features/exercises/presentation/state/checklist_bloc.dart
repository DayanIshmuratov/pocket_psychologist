import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/get_check_list/get_check_list.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state.dart';

class CheckListBloc extends  Bloc<CheckListEvent, CheckListState> {
  final GetCheckLists getCheckLists;
  CheckListBloc({required this.getCheckLists}) : super(CheckListStateEmpty()) {
  on<OnCheckListEvent>(_onEvent);
  }
  Future<void> _onEvent(OnCheckListEvent event, Emitter<CheckListState> emit) async {
    emit(CheckListStateLoading());
    final result = await getCheckLists();
    emit(CheckListStateLoaded(result));
  }

}