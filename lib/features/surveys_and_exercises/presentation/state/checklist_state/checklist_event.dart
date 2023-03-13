import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_entity.dart';

abstract class CheckListEvent extends Equatable {
  const CheckListEvent();

  @override
  List<Object?> get props => [];
}

class GetCheckListEvent extends CheckListEvent {}
// class GetQuestionEvent extends CheckListEvent {}
// class UpdateQuestionEvent extends CheckListEvent {
//   final QuestionEntity questionEntity;
//   UpdateQuestionEvent({required this.questionEntity});
// }

