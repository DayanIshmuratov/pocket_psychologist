
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/question_with_answer_entity.dart';

class QuestionWithAnswerModel extends QuestionWithAnswerEntity {
  QuestionWithAnswerModel({required super.id, required super.question, required super.nameId, required super.answerId, required super.answerName});

  factory QuestionWithAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionWithAnswerModel(
        id: json['question_id'],
        question: json['question'],
        nameId: json['survey_id'],
        answerId: json['question_answer_id'],
        answerName: json['answer_name']
    );
  }
}