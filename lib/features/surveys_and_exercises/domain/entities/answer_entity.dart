import 'package:equatable/equatable.dart';
import 'survey_entity.dart';


class AnswerEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String answer;
  final int questionId;
  final int value;
  final int lieValue;

  AnswerEntity({required this.id, required this.answer, required this.value, required this.lieValue, required this.questionId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, answer, value, lieValue, questionId];
}