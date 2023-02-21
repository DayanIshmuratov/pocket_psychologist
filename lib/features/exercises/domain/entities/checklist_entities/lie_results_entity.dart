import 'package:equatable/equatable.dart';

class LieResultEntity extends Equatable {
  final int id;
  final String result;
  final int valueLessThan;

  LieResultEntity({required this.id, required this.result, required this.valueLessThan});

  @override
  // TODO: implement props
  List<Object?> get props => [id, result, valueLessThan];
}