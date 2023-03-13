import 'package:pocket_psychologist/features/surveys_and_exercises/domain/repositories/survey_repository.dart';
import '../../../../../core/usecases/usecase_with_parameters.dart';
import '../../entities/image_entity.dart';
import '../question_usecases/get_questions.dart';

class GetImages extends UseCaseWithParameters<Future<List<ImageEntity>>, GetByIdParameters>{
  final SurveyRepository repository;
  GetImages({required this.repository});
  Future<List<ImageEntity>> call(GetByIdParameters parameters) {
    return repository.getImages(parameters.id);
  }
}