import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/update_checklist.dart';

class UpdateQuestion extends UseCaseWithParameters<Future<void>, UpdateTableParameters<QuestionEntity>>{
  final CheckListRepository repository;
  UpdateQuestion({required this.repository});

  Future<void> call(UpdateTableParameters<QuestionEntity> updateTableParameters) async {
    await repository.updateQuestion(updateTableParameters.entity);
  }
}

class UpdateTableParameters<T extends BaseEntity> extends Equatable{
  final T entity;
  UpdateTableParameters({required this.entity});
  @override
  List<Object?> get props => [entity];
}