import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class CheckListModel extends CheckListEntity {
  // final String result;

  CheckListModel({
    required id,
    required name,
    required description,
    required questions,
}) : super(
      id: id,
      name: name,
      description: description,
      questions: questions,
);

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
        id: json['name_id'],
        name: json['checklist_name'],
        description: json['description'],
        questions: QuestionModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson(CheckListModel model) {
    return {
      'name_id' : model.id,
      'checklist_name' : model.name,
      'description' : model.description,
    };
  }
  //
  // List<String> toList(String string) {
  //   return string.split('@');
  // }
}
