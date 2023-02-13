import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}

class OnQuestionEvent extends QuestionEvent {
  final int nameId;
  OnQuestionEvent({required this.nameId});
}