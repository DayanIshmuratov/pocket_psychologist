import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String path;
  final int exerciseId;

  ImageEntity({required this.id, required this.path, required this.exerciseId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, path, exerciseId];

}