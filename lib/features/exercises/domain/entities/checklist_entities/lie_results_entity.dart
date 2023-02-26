import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class LieResultEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String result;
  final int maxValue;
  final int minValue;

  LieResultEntity({required this.id, required this.result, required this.maxValue, required this.minValue});

  @override
  // TODO: implement props
  List<Object?> get props => [id, result, maxValue, minValue];
}