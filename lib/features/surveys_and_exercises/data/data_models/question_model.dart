import '../../domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({required super.id, required super.question, required super.nameId, required super.answerId});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
     return QuestionModel(
         id: json['question_id'],
         question: json['question'],
         nameId: json['survey_id'],
         answerId: json['question_answer_id'],
     );
    }

  Map<String, dynamic> toMap() {
    return {
      'question_id' : id,
      'question_answer_id' : answerId,
    };
  }
}