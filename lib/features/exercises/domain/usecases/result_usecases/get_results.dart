import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../repositories/checklist_repository.dart';
import '../question_usecases/get_questions.dart';

class GetResults extends UseCaseWithParameters<Future<List<ResultEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetResults({required this.repository});
  Future<List<ResultEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getResults(getByIdParameters.id);
  }
}