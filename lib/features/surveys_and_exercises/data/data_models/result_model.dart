import 'dart:convert';

import '../../domain/entities/result_entity.dart';


class ResultModel extends ResultEntity {
  ResultModel({required super.minValue, required super.maxValue, required super.id, required super.result});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
    id : json['id'],
    result : json['result'],
    minValue : json['min_value'],
    maxValue : json['max_value'],
    );
  }
}