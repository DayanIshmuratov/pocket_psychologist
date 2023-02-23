import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';

class GetAnswers extends UseCaseWithParameters<Future<List<AnswerEntity>>, GetByIdParameters> {
  final CheckListRepository repository;

  GetAnswers({required this.repository});

  @override
  Future<List<AnswerEntity>> call(GetByIdParameters parameters) {
    return repository.getAnswers(parameters.id);
  }
}