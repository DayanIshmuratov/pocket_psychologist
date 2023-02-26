import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../repositories/checklist_repository.dart';
import '../question_usecases/get_questions.dart';

class GetExercises extends UseCaseWithParameters<Future<List<ExercisesEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetExercises({required this.repository});
  Future<List<ExercisesEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getExercises(getByIdParameters.id);
  }
}