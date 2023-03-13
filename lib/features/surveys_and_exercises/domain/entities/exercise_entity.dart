import 'package:equatable/equatable.dart';
import 'survey_entity.dart';

class ExercisesEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String name;
  final int checklistId;

  ExercisesEntity({required this.id, required this.name, required this.checklistId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, checklistId];
}