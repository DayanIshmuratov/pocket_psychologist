import '../../domain/entities/checklist_entities/checklist_entity.dart';

abstract class BaseState {}

class EmptyState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState<T extends BaseEntity> extends BaseState {
  final T entity;

  LoadedState({required this.entity});
}

class LoadedListState<T extends BaseEntity> extends BaseState {
  final List<T> entities;

  LoadedListState({required this.entities});
}

class ErrorState extends BaseState {
  final String text;

  ErrorState({required this.text});
}

