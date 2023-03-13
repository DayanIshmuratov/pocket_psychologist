
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/repositories/survey_repository.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/question_entity.dart';

class GetQuestions extends UseCaseWithParameters<Future<List<QuestionEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetQuestions({required this.repository});
  Future<List<QuestionEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getQuestions(getByIdParameters.id);
  }
}

class GetByIdParameters {
  final int id;
  GetByIdParameters({required this.id});
}