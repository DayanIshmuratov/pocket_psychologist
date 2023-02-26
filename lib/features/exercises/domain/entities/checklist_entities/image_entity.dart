import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

class ImageEntity extends BaseEntity with EquatableMixin {
  final int id;
  final String path;
  final int exerciseId;

  ImageEntity({required this.id, required this.path, required this.exerciseId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, path, exerciseId];

}