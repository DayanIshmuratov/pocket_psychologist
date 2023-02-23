import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/exercise_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/lie_result_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/question_model.dart';
import 'package:pocket_psychologist/features/exercises/data/data_models/result_model.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class CheckListModel extends CheckListEntity {
  // final bool isDone;

  CheckListModel({required super.id, required super.name, required super.description, required super.instruction, required super.sum, required super.done, required super.count, required super.lieSum});

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
        id: json['checklist_id'],
        name: json['checklist_name'],
        description: json['description'],
        instruction: json['instruction'],
        lieSum: json['lie_sum'],
        sum: json['sum'],
        done: json['done'],
        count: json['count'],
        // questions: QuestionModel.fromJson(json),
        // exercises: ExercisesModel(id: id, name: name, images: images),
        // lieResults: LieResultModel(id: id, result: result, valueLessThan: valueLessThan),
        // results: ResultModel(id: id, result: result, valueLessThan: valueLessThan),
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'checklist_id' : id,
  //     'sum' : sum,
  //     'count' : count,
  //   };
  // }
  //
  // List<String> toList(String string) {
  //   return string.split('@');
  // }
}
