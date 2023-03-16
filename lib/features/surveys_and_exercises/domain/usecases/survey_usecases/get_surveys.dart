

import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/repositories/survey_repository.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../question_usecases/get_questions.dart';

class GetSurveys extends UseCaseWithParameters<Future<List<SurveyEntity>>, GetByIdParameters> {
  final SurveyRepository repository;
  GetSurveys({required this.repository});
  @override
  Future<List<SurveyEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getSurveys(getByIdParameters.id);
  }
}