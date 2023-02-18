import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String path;

  ImageEntity({required this.id, required this.path});

  @override
  // TODO: implement props
  List<Object?> get props => [id, path];

}