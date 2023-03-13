
import '../../domain/entities/survey_entity.dart';

class SurveyModel extends SurveyEntity {

  SurveyModel({required super.id, required super.name, required super.description, required super.instruction, required super.sum, required super.done, required super.count, required super.lieSum});

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
        id: json['survey_id'],
        name: json['survey_name'],
        description: json['description'],
        instruction: json['instruction'],
        lieSum: json['lie_sum'],
        sum: json['sum'],
        done: json['done'],
        count: json['count'],
    );
  }
}
