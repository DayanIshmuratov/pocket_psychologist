
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/lie_results_entity.dart';

import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../repositories/checklist_repository.dart';
import '../question_usecases/get_questions.dart';

class GetImages extends UseCaseWithParameters<Future<List<ImageEntity>>, GetByIdParameters>{
  final CheckListRepository repository;
  GetImages({required this.repository});
  Future<List<ImageEntity>> call(GetByIdParameters getByIdParameters) {
    return repository.getImages(getByIdParameters.id);
  }
}