import 'package:equatable/equatable.dart';

abstract class CheckListEvent extends Equatable {
  const CheckListEvent();

  @override
  List<Object?> get props => [];
}

class OnCheckListEvent extends CheckListEvent {
}