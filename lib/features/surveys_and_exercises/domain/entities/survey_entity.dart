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

  SurveyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.instruction,
    required this.sum,
    required this.lieSum,
    required this.done,
    required this.count,
});

  @override
  List<Object?> get props =>
      [id, name, description, instruction, sum, done, count];
}
