import '../../domain/entities/lie_results_entity.dart';

class LieResultModel extends LieResultEntity {
  LieResultModel({required super.id, required super.result, required super.maxValue, required super.minValue});

  factory LieResultModel.fromJson(Map<String, dynamic> json) {
    return LieResultModel(
        id: json['id'],
        result: json['lie_result'],
        maxValue: json['max_value'],
        minValue: json['min_value']);
  }
}