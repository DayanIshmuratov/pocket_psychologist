import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/exceptions/exceptions.dart';
import '../../../../../core/logger/logger.dart';
import '../../../domain/entities/lie_results_entity.dart';
import '../../../domain/usecases/lie_result_usecases/get_lie_results.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../bloc_states.dart';

class LieResultCubit extends Cubit<BaseState> {
  final GetLieResults getResults;
  LieResultCubit({required this.getResults}) : super(LoadingState());

  Future<void> loadListData(int id) async {
    try {
      final result = await getResults(GetByIdParameters(id: id));
      emit(LoadedListState<LieResultEntity>(entities: result));
    } on CacheException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}