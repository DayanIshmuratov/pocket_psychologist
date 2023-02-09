import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';

abstract class CheckListState extends Equatable {
  const CheckListState();

  List<Object?> get props => [];
}

class CheckListStateEmpty extends CheckListState {}

class CheckListStateLoading extends CheckListState {}

class CheckListStateLoaded extends CheckListState {
  final List<CheckListEntity> checkLists;

  const CheckListStateLoaded(this.checkLists);

}

class CheckListStateError extends CheckListState {}