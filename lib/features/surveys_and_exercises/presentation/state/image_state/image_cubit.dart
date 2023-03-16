import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/exceptions/exceptions.dart';
import '../../../../../core/logger/logger.dart';
import '../../../domain/entities/image_entity.dart';
import '../../../domain/usecases/image_usecases/get_images.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../bloc_states.dart';

class ImageCubit extends Cubit<BaseState> {
  final GetImages getImages;
  ImageCubit({required this.getImages}) : super(LoadingState());

  Future<void> loadListData(int id) async {
    try {
      final result = await getImages(GetByIdParameters(id: id));
      emit(LoadedListState<ImageEntity>(entities: result));
    } on CacheException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}