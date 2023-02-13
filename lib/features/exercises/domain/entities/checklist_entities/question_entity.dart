import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final List<int> id;
  final List<String> question;
  List<int> answer;
  // final int nameId;

  QuestionEntity({required this.id, required this.question, required this.answer});
  @override
  // TODO: implement props
  List<Object?> get props => [id, question, answer];

}