import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';

class ExercisesEntity extends Equatable {
  final List<int> id;
  final List<String> name;
  final List<ImageEntity> images;

  ExercisesEntity({required this.id, required this.name, required this.images});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, images];
}