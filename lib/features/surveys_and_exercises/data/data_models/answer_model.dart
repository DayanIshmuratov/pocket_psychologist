import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/answer_entity.dart';

class AnswerModel extends AnswerEntity {
  AnswerModel({
    required super.id,
    required super.answer,
    required super.value,
    required super.lieValue,
    required super.questionId,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
        id: json['answer_id'],
        answer: json['answer_name'],
        value: json['value'],
        lieValue: json['lie_value'],
        questionId: json['question_id']
    );

  }
  Map<String, dynamic> toMap() {
    return {
      'answer_id' : id,
    };
  }

}
