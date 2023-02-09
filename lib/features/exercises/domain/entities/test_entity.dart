import 'package:equatable/equatable.dart';

class TestEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final Map<String, List<String>> questions;
  final int answer;
  final int result;
  final Map<String, List<String>> recommendations;

  const TestEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
    required this.answer,
    required this.result,
    required this.recommendations
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, description, questions, answer, result, recommendations];
}
