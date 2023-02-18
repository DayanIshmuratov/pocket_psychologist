import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';

import 'exercise_entity.dart';
import 'lie_results_entity.dart';

class CheckListEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? instruction;
  QuestionEntity questions;
  ResultEntity results;
  LieResultEntity? lieResults;
  ExercisesEntity exercises;

  CheckListEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.instruction,
    required this.questions,
    required this.results,
    required this.lieResults,
    required this.exercises,
});

  @override
  List<Object?> get props =>
      [id, name, description, instruction, questions, results, lieResults, exercises];
}
