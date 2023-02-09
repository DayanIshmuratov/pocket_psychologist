import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';

class CheckListModel extends CheckListEntity {

  CheckListModel({
    required id,
    required name,
    required description,
    required questions,
    required result,
    required recommendations})
      : super(
      id: id,
      name: name,
      description: description,
      questions: questions,
      result: result,
      recommendations: recommendations);

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(id: json['ID'],
        name: json['Name'],
        description: json['Description'],
        questions: json['Questions'].toString().split('@'),
        result: json['Result'],
        recommendations: json['Recommendations'].toString().split('@'));
  }

  Map<String, dynamic> toJson(CheckListModel model) {
    return {
      'Id' : model.id,
      'Name' : model.name,
      'Description' : model.description,
      'Questions' : model.questions.join("@"),
      'Result' : model.result,
      'Recommendations' : model.recommendations.join("@"),
    };
  }
  //
  // List<String> toList(String string) {
  //   return string.split('@');
  // }
}
