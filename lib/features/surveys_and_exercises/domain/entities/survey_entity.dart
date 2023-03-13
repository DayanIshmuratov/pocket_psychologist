import 'package:equatable/equatable.dart';

abstract class BaseEntity {}

class SurveyEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String name;
  final String? description;
  final String? instruction;
  final int sum;
  final int lieSum;
  final int done;
  final int count;
  // final bool done;

  SurveyEntity({
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
    // required this.surveys_and_exercises,
});

  @override
  List<Object?> get props =>
      [id, name, description, instruction, sum, done, count];
}
