
import '../../domain/entities/exercise_entity.dart';

class ExercisesModel extends ExercisesEntity {
  ExercisesModel({required super.id, required super.name, required super.surveyId});
  
  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    return ExercisesModel(id: json['exercise_id'], name: json['exercise_name'], surveyId: json['survey_id']);
  }
}