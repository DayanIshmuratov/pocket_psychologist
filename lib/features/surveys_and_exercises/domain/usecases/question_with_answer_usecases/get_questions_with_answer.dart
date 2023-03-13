import 'package:pocket_psychologist/features/surveys_and_exercises/domain/repositories/survey_repository.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/question_with_answer_entity.dart';
import '../question_usecases/get_questions.dart';

class GetQuestionsWithAnswer extends UseCaseWithParameters<Future<List<QuestionWithAnswerEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetQuestionsWithAnswer({required this.repository});
  @override
  Future<List<QuestionWithAnswerEntity>> call(GetByIdParameters parameters) {
    return repository.getQuestionsWithAnswers(parameters.id);
  }
}
