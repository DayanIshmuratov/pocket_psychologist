import '../../domain/entities/checklist_entities/checklist_entity.dart';

abstract class BaseEvent {}

// class LoadListEvent extends BaseEvent {}
class LoadEvent extends BaseEvent {
  final int? id;
  final int? secondId;

  LoadEvent({this.id, this.secondId});

}

class UpdateEvent<T extends BaseEntity> extends BaseEvent {
  final T entity;
  UpdateEvent({required this.entity});
}
