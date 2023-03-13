import 'package:equatable/equatable.dart';
import 'survey_entity.dart';
class ResultEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String result;
  final int minValue;
  final int maxValue;

  ResultEntity({required this.minValue, required this.maxValue,required this.id, required this.result});

  @override
  // TODO: implement props
  List<Object?> get props => [id, result, minValue, maxValue];
}