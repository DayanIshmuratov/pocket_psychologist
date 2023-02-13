import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart' ;

abstract class QuestionState extends Equatable {
  const QuestionState();

  List<Object?> get props => [];
}

class QuestionStateEmpty extends QuestionState {}

class QuestionStateLoading extends QuestionState {}

class QuestionStateLoaded extends QuestionState {
  final List<QuestionEntity> questions;
  const QuestionStateLoaded(this.questions);
}

class QuestionStateError extends QuestionState {
  final String errorMessage;
  QuestionStateError(this.errorMessage);
}