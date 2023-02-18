import 'package:equatable/equatable.dart';

class AnswerEntity extends Equatable {
  final List<int> id;
  final List<String> answer;
  final List<int> value;
  final List<int> lieValue;

  AnswerEntity({required this.id, required this.answer, required this.value, required this.lieValue});

  @override
  // TODO: implement props
  List<Object?> get props => [id, answer, value, lieValue];
}