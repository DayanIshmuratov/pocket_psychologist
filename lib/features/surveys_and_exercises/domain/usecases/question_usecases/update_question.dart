import 'package:equatable/equatable.dart';
import 'package:pocket_psychologist/core/usecases/usecase_with_parameters.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/repositories/survey_repository.dart';

import '../../entities/question_entity.dart';
import '../../entities/survey_entity.dart';

class UpdateQuestion extends UseCaseWithParameters<Future<void>, UpdateTableParameters<QuestionEntity>>{
  final SurveyRepository repository;
  UpdateQuestion({required this.repository});

  @override
  Future<void> call(UpdateTableParameters<QuestionEntity> parameters) async {
    await repository.updateQuestion(parameters.entity);
  }
}

class UpdateTableParameters<T extends BaseEntity> extends Equatable{
  final T entity;
  const UpdateTableParameters({required this.entity});
  @override
  List<Object?> get props => [entity];
}