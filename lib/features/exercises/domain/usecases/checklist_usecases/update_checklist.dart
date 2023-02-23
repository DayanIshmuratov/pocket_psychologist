import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';

class UpdateCheckList extends UseCaseWithParameters<Future<void>, UpdateTableParameters<CheckListEntity>> {
  CheckListRepository repository;
  UpdateCheckList({required this.repository});
  Future<void> call(UpdateTableParameters<CheckListEntity> updateTableParameters) {
    return repository.updateCheckList(updateTableParameters.entity);
  }
}

class UpdateTableParameters<T extends BaseEntity> extends Equatable{
  final T entity;
  UpdateTableParameters({required this.entity});
  @override
  List<Object?> get props => [entity];
}