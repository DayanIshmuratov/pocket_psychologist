import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/exercise_entity.dart';
import '../../repositories/survey_repository.dart';
import '../question_usecases/get_questions.dart';

class GetExercises extends UseCaseWithParameters<Future<List<ExercisesEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetExercises({required this.repository});
  Future<List<ExercisesEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getExercises(getByIdParameters.id);
  }
}