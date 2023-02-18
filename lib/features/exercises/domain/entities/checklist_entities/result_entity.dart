import 'package:equatable/equatable.dart';

class ResultEntity extends Equatable {
  final List<int> id;
  final List<String> result;
  final List<int> valueLessThan;

  ResultEntity({required this.id, required this.result, required this.valueLessThan});

  @override
  // TODO: implement props
  List<Object?> get props => [id, result, valueLessThan];
}