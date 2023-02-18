import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';

class QuestionEntity extends Equatable {
  final List<int> id;
  final List<String> question;
  List<int> answer;
  List<AnswerEntity> answers;
  // final int nameId;

  QuestionEntity({required this.id, required this.question, required this.answer,required this.answers});
  @override
  // TODO: implement props
  List<Object?> get props => [id, question, answer, answers];

}