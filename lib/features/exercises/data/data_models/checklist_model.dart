import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/exercise_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/lie_result_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/result_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class CheckListModel extends CheckListEntity {
  // final String result;

  CheckListModel({
    required id,
    required name,
    required description,
    required questions,
    required instruction,
    required exercises,
    required lieResults,
    required results,
}) : super(
      id: id,
      name: name,
      description: description,
      questions: questions,
      instruction: instruction,
      exercises: exercises,
      lieResults: lieResults,
      results: results,
);

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
        id: json['name_id'],
        name: json['checklist_name'],
        description: json['description'],
        instruction: json['instruction'],
        questions: QuestionModel.fromJson(json),
        exercises: ExercisesModel(id: id, name: name, images: images),
        lieResults: LieResultModel(id: id, result: result, valueLessThan: valueLessThan),
        results: ResultModel(id: id, result: result, valueLessThan: valueLessThan),
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
