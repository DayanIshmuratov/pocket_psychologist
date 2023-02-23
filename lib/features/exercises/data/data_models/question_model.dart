import 'package:pocket_psychologist/features/exercises/data/data_models/answer_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({required super.id, required super.question, required super.nameId, required super.answerId});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // List<int> id = json['answer_id'].toString().split("@").map((e) => int.parse(e)).toList();
    // List<String> answer = json['answer_name'].toString().split("@");
    // List<int> value = json['value'].toString().split("@").map((e) => int.parse(e)).toList();
    // List<int> lieValue = json['lie_value'].toString().split("@").map((e) => int.parse(e)).toList();
    // // List<int> isChoosen = json['is_choosen'].toString().split("@").map((e) => int.parse(e)).toList();
    // List<AnswerModel> result = [];
    // for (int i = 0; i < id.length; i++) {
    //   result.add(AnswerModel(
    //     id: id[i],
    //     answer: answer[i],
    //     value: value[i],
    //     lieValue: lieValue[i],
    //     // isChoosen: isChoosen[i]
    //   )
    //   );
    // }
     return QuestionModel(
         id: json['question_id'],
         question: json['question'],
         nameId: json['name_id'],
         answerId: json['question_answer_id'],
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