import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/lie_results_entity.dart';
import '../../repositories/survey_repository.dart';
import '../question_usecases/get_questions.dart';

class GetLieResults extends UseCaseWithParameters<Future<List<LieResultEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetLieResults({required this.repository});
  Future<List<LieResultEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getLieResults(getByIdParameters.id);
  }
}