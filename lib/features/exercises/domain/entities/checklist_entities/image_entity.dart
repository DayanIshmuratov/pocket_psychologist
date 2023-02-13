import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String path;
  final int exerciseId;

  ImageEntity(this.id, this.path, this.exerciseId);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}