import 'package:equatable/equatable.dart';

class CheckListEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> questions;
  final int? result;
  final List<String> recommendations;

  CheckListEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
    required this.result,
    required this.recommendations
});

  @override
  List<Object?> get props =>
      [id, name, description, questions, result, recommendations];
}
