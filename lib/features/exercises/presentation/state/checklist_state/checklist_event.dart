import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';

abstract class CheckListEvent extends Equatable {
  const CheckListEvent();

  @override
  List<Object?> get props => [];
}

class OnGetCheckListEvent extends CheckListEvent {}
class OnUpdateCheckListEvent extends CheckListEvent {
  final CheckListEntity checkListEntity;
  OnUpdateCheckListEvent({required this.checkListEntity});
}

