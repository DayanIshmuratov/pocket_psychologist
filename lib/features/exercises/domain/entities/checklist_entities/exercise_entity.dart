import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';

class ExercisesEntity extends Equatable {
  final int id;
  final String name;
  final String nameId;

  const ExercisesEntity({required this.id, required this.name, required this.nameId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, nameId];
}