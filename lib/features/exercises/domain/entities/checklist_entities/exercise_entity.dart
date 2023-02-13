import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final int id;
  final String name;
  final nameId;

  ExerciseEntity(this.id, this.name, this.nameId);

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, nameId];


}