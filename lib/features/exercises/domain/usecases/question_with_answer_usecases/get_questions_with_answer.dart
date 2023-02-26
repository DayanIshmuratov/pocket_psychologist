import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';

class GetQuestionsWithAnswer extends UseCaseWithParameters<Future<List<QuestionWithAnswerEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetQuestionsWithAnswer({required this.repository});
  Future<List<QuestionWithAnswerEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getQuestionsWithAnswers(getByIdParameters.id);
  }
}
