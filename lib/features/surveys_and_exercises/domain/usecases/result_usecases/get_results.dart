import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/result_entity.dart';
import '../../repositories/survey_repository.dart';
import '../question_usecases/get_questions.dart';

class GetResults extends UseCaseWithParameters<Future<List<ResultEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetResults({required this.repository});
  @override
  Future<List<ResultEntity>> call(GetByIdParameters parameters) {
    return repository.getResults(parameters.id);
  }
}