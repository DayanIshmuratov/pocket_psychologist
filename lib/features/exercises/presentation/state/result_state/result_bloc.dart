import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/result_usecases/get_results.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';

import '../bloc_events.dart';

class ResultBloc extends Bloc<BaseEvent, BaseState> {
  final GetResults getResults;
  ResultBloc({required this.getResults}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
      final result = await getResults(GetByIdParameters(id: event.id ?? 0));
      emit(LoadedListState<ResultEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
      // print('$s');
      // }
    });
  }
}