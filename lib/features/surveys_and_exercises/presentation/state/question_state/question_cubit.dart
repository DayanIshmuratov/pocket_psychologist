import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import '../../../domain/entities/question_entity.dart';
import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../../../domain/usecases/question_usecases/update_question.dart';
import '../bloc_states.dart';

class QuestionCubit extends Cubit<BaseState> {
  final GetQuestions getQuestion;
  final UpdateQuestion updateQuestion;
  QuestionCubit({required this.getQuestion, required this.updateQuestion}) : super(LoadingState());
  // {
    // on<LoadListEvent>((LoadListEvent event, Emitter<BaseState> emit) async {
    //   emit(LoadingState());
    //   try {
    //     final result = await getQuestion(GetByIdParameters(id: event.id ?? 0));
    //     emit(LoadedListState<QuestionEntity>(entities: result));
    //   }
    //   catch (e) {
    //     emit(ErrorState(text: e.toString()));
    //   }
    // });
    // on<UpdateEvent<QuestionEntity>>((UpdateEvent<QuestionEntity> event, Emitter<BaseState> emit) async {
    // });
  // }

  Future<void> loadListData(int? id) async {
    try {
      final result = await getQuestion(GetByIdParameters(id: id ?? 0));
      emit(LoadedListState<QuestionEntity>(entities: result));
    }
    on LocalException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }

  Future<void> updateData(QuestionEntity entity) async {
    try {
      await updateQuestion(UpdateTableParameters(entity: entity));
    }
    on LocalException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
    }
  }
}