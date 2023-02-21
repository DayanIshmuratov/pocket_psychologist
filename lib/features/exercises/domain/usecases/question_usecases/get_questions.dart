import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class GetQuestion {
  final CheckListRepository repository;
  GetQuestion({required this.repository});

  Future<QuestionEntity> call(int nameId, int questionId) {
    return repository.getQuestion(nameId, questionId);
  }
}