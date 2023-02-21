import 'package:equatable/equatable.dart';

class ResultEntity extends Equatable {
  final int id;
  final String result;
  final int valueLessThan;

  ResultEntity({required this.id, required this.result, required this.valueLessThan});

  @override
  // TODO: implement props
  List<Object?> get props => [id, result, valueLessThan];
}