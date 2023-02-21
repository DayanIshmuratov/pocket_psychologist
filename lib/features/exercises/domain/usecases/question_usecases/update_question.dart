import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class UpdateAnswer{
  final CheckListRepository repository;
  UpdateAnswer({required this.repository});

  Future<void> call(AnswerEntity entity) async {
    await repository.updateAnswer(entity);
  }
}