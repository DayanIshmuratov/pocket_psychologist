import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import '../../entities/answer_entity.dart';
import '../../repositories/survey_repository.dart';
import '../question_usecases/get_questions.dart';

class GetAnswers extends UseCaseWithParameters<Future<List<AnswerEntity>>, GetByIdParameters> {
  final SurveyRepository repository;

  GetAnswers({required this.repository});

  @override
  Future<List<AnswerEntity>> call(GetByIdParameters parameters) {
      final result = repository.getAnswers(parameters.id);
      return result;
  }
}