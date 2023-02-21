import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';

class AnswerModel extends AnswerEntity {
  AnswerModel({
    required super.id,
    required super.answer,
    required super.value,
    required super.lieValue,
    required super.isChoosen,
  });

  Map<String, dynamic> toMap() {
    return {
      'answer_id' : id,
      // 'answer_name_id' : answer,
      // 'value' : value,
      // 'lie_value' : lieValue,
      'is_choosen' : isChoosen,
    };
  }

// AnswerModel.fromJson(Map<String, dynamic> json) {
//   this.
// }

//   List<AnswerModel> fromJson(Map<String, dynamic> json) {
//     List<int> id = json['id'].toString().split("@").map((e) => int.parse(e)).toList();
//     List<String> answer = json['answer_name'].toString().split("@");
//     List<int> value = json['value'].toString().split("@").map((e) => int.parse(e)).toList();
//     List<int> lie_value = json['lie_value'].toString().split("@").map((e) => int.parse(e)).toList();
//     List<int> is_choosen = json['is_choosen'].toString().split("@").map((e) => int.parse(e)).toList();
//     List<AnswerModel> result = [];
//     for (int i = 0; i < id.length; i++) {
//       result.add(AnswerModel(
//         id: id[i],
//         answer: answer[i],
//         value: value[i],
//         lieValue: lie_value[i],
//         isChoosen: is_choosen[i]
//       )
//       );
//     }
//     return result;
//   }

}
// }
