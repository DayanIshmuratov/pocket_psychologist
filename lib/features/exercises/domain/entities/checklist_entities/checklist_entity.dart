import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';

import 'exercise_entity.dart';
import 'lie_results_entity.dart';
abstract class BaseEntity {}

class CheckListEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String name;
  final String? description;
  final String? instruction;
  final int sum;
  final int lieSum;
  final int done;
  final int count;
  // final bool done;

  CheckListEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.instruction,
    required this.sum,
    required this.lieSum,
    required this.done,
    required this.count,
    // required this.questions,
    // required this.results,
    // required this.lieResults,
    // required this.exercises,
});

  @override
  List<Object?> get props =>
      [id, name, description, instruction, sum, done, count];
}
