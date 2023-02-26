import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class QuestionEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String question;
  final int nameId;

  int answerId;


  QuestionEntity({required this.id, required this.question, required this.nameId, required this.answerId});
  @override
  // TODO: implement props
  List<Object?> get props => [id, question, nameId, answerId];

}