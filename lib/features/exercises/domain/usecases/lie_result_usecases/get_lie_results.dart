import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../repositories/checklist_repository.dart';
import '../question_usecases/get_questions.dart';

class GetLieResults extends UseCaseWithParameters<Future<List<LieResultEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetLieResults({required this.repository});
  Future<List<LieResultEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getLieResults(getByIdParameters.id);
  }
}