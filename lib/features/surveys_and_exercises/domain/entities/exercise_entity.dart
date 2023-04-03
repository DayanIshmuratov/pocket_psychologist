import 'package:equatable/equatable.dart';
import 'survey_entity.dart';

class ExercisesEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String name;
  final int surveyId;

  ExercisesEntity({required this.id, required this.name, required this.surveyId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, surveyId];
}