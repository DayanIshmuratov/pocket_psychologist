import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/result_entity.dart';
import '../../../../../core/exceptions/exceptions.dart';
import '../../../../../core/logger/logger.dart';
import '../../../domain/entities/question_with_answer_entity.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../../../domain/usecases/result_usecases/get_results.dart';
import '../bloc_events.dart';
import '../bloc_states.dart';

class ResultCubit extends Cubit<BaseState> {
  final GetResults getResults;
  ResultCubit({required this.getResults}) : super(LoadingState());

  Future<void> loadListData(int id) async {
    try {
      final result = await getResults(GetByIdParameters(id: id));
      emit(LoadedListState<ResultEntity>(entities: result));
    } on LocalException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}