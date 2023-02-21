import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

abstract class CheckListState extends Equatable {
  const CheckListState();

  List<Object?> get props => [];
}

class CheckListStateEmpty extends CheckListState {}

class CheckListStateLoading extends CheckListState {}

class CheckListStateLoaded<T> extends CheckListState {
  final T checkLists;
  const CheckListStateLoaded(this.checkLists);
}

class CheckListStateError extends CheckListState {
  final String errorMessage;
  CheckListStateError(this.errorMessage);
}

//
// class QuestionStateEmpty extends CheckListState {}
//
// class QuestionStateLoading extends CheckListState {}
//
// class QuestionStateLoaded extends CheckListState {
//   final List<QuestionEntity> questions;
//   const QuestionStateLoaded(this.questions);
// }
//
// class QuestionStateError extends CheckListState {
//   final String errorMessage;
//   QuestionStateError(this.errorMessage);
// }