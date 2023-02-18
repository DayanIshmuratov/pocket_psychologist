import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({required super.id, required super.question, required super.answer, required super.answers});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
     return QuestionModel(
            id: json['question_id'].toString().split('@').map((e) => int.parse(e)).toList(),
            question: json['name_question'].toString().split("@"),
            answer: json['answers'].toString().split('@').map((e) => int.parse(e)).toList(),
            answers:
     );
    }

  Map<String, dynamic> toJson(QuestionModel model) {
    return {
      'question_id' : model.id,
      'name_question' : model.question,
      'answers' : model.answer,
      // 'name_id' : model.nameId,
    };
  }
}