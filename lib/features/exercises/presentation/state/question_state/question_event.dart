import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}
class GetQuestionEvent extends QuestionEvent {
  final int nameId;
  GetQuestionEvent({required this.nameId});
}
class UpdateQuestionEvent extends QuestionEvent {
  final QuestionEntity entity;
  UpdateQuestionEvent({required this.entity});
}