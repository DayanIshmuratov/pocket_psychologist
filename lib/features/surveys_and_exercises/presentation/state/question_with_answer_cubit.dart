import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';
import '../../domain/entities/question_with_answer_entity.dart';
import '../../domain/usecases/question_usecases/get_questions.dart';
import '../../domain/usecases/question_with_answer_usecases/get_questions_with_answer.dart';
import 'bloc_states.dart';

class QuestionWithAnswerCubit extends Cubit<BaseState> {
  final GetQuestionsWithAnswer getQuestion;
  QuestionWithAnswerCubit({required this.getQuestion}) : super(LoadingState());

  Future<void> loadListData(int id) async {
    try {
      final result = await getQuestion(GetByIdParameters(id: id));
      emit(LoadedListState<QuestionWithAnswerEntity>(entities: result));
    } on CacheException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}