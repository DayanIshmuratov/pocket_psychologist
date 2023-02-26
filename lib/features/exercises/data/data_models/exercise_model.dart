import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';

class ExercisesModel extends ExercisesEntity {
  ExercisesModel({required super.id, required super.name, required super.checklistId});
  
  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    return ExercisesModel(id: json['exercise_id'], name: json['name_exercise'], checklistId: json['name_id']);
  }
}