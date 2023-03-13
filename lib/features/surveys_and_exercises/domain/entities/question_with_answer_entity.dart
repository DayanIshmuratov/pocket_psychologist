import 'package:equatable/equatable.dart';
import 'survey_entity.dart';
class QuestionWithAnswerEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String? question;
  final int nameId;
  // final List<AnswerEntity> answers;
  int answerId;
  final String answerName;
  // final int nameId;

  QuestionWithAnswerEntity({required this.answerName, required this.id, required this.question, required this.nameId, required this.answerId});
  @override
  // TODO: implement props
  List<Object?> get props => [id, question, nameId, answerId, answerName];

}