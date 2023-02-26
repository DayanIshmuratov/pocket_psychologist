import '../../domain/entities/checklist_entities/checklist_entity.dart';

abstract class BaseEvent {}

// class LoadListEvent extends BaseEvent {}
class LoadListEvent extends BaseEvent {
  final int? id;
  final int? secondId;

  LoadListEvent({this.id, this.secondId});
}

class LoadEvent extends BaseEvent {
  final int id;
  LoadEvent({required this.id});
}

class UpdateEvent<T extends BaseEntity> extends BaseEvent {
  final T entity;
  UpdateEvent({required this.entity});
}
