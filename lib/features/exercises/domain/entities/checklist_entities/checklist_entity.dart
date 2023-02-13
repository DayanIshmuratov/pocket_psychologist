import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

class CheckListEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  QuestionEntity questions;

  CheckListEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
});

  @override
  List<Object?> get props =>
      [id, name, description, questions];
}
