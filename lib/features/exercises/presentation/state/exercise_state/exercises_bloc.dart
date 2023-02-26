import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/exercises_usecases/get_exercises.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/image_usecases/get_images.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/lie_result_usecases/get_lie_results.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';

class ExercisesBloc extends Bloc<BaseEvent, BaseState> {
  final GetExercises getExercises;
  ExercisesBloc({required this.getExercises}) : super(EmptyState()) {
    on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
      emit(LoadingState());
      // try {
      final result = await getExercises(GetByIdParameters(id: event.id ?? 0));
      emit(LoadedListState<ExercisesEntity>(entities: result));
      // }
      // catch (e) {
      //   emit(ErrorState(text: e.toString()));
      // print('$s');
      // }
    });
  }
}