import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';

class QuestionWithAnswerModel extends QuestionWithAnswerEntity {
  QuestionWithAnswerModel({required super.id, required super.question, required super.nameId, required super.answerId, required super.answerName});

  factory QuestionWithAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionWithAnswerModel(
        id: json['question_id'],
        question: json['question'],
        nameId: json['name_id'],
        answerId: json['question_answer_id'],
        answerName: json['answer_name']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question_id' : id,
      // 'question' : question,
      'question_answer_id' : answerId,
      // 'name_id' : model.answerId,
      // 'name_id' : model.nameId,
    };
  }
}