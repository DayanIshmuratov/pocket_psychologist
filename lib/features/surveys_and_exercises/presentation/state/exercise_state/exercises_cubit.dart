import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/exercise_entity.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../../../../core/logger/logger.dart';
import '../../../domain/usecases/exercises_usecases/get_exercises.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../bloc_states.dart';

class ExercisesCubit extends Cubit<BaseState> {
  final GetExercises getExercises;
  ExercisesCubit({required this.getExercises}) : super(LoadingState());
  Future<void> loadListData(int id) async {
    try {
      final result = await getExercises(GetByIdParameters(id: id));
      emit(LoadedListState<ExercisesEntity>(entities: result));
    } on LocalException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}