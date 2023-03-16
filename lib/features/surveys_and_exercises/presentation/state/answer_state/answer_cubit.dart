
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../../../../core/logger/logger.dart';
import '../../../domain/entities/answer_entity.dart';
import '../../../domain/usecases/answer_usecases/get_answers.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../bloc_states.dart';
// import 'package:sqflite/sqflite.dart';

class AnswerCubit extends Cubit<BaseState> {
  // final UpdateAnswer updateAnswer;
  final GetAnswers getAnswers;
  AnswerCubit({required this.getAnswers}) : super(LoadingState());

  loadListData(int id) async {
    try {
      final result = await getAnswers(GetByIdParameters(id: id));
      emit(LoadedListState<AnswerEntity>(entities: result));
    } on CacheException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}