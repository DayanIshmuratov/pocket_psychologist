import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/lie_result_usecases/get_lie_results.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';

class LieResultBloc extends Bloc<BaseEvent, BaseState> {
  final GetLieResults getResults;
  LieResultBloc({required this.getResults}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
      final result = await getResults(GetByIdParameters(id: event.id ?? 0));
      emit(LoadedListState<LieResultEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
      // print('$s');
      // }
    });
  }
}