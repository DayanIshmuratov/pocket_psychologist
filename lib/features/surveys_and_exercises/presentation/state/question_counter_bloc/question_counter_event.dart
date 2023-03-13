part of 'question_counter_bloc.dart';

abstract class QuestionCounterEvent extends Equatable {
  const QuestionCounterEvent();
}
class QuestionCounterInc extends QuestionCounterEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class QuestionCounterDec extends QuestionCounterEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}