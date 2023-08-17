import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/survey_entity.dart';

import '../../../domain/usecases/question_usecases/get_questions.dart';
import '../../../domain/usecases/survey_usecases/get_surveys.dart';
import '../bloc_states.dart';

class SurveyCubit extends Cubit<BaseState> {
  final GetSurveys getSurveys;
  SurveyCubit({required this.getSurveys}) : super(EmptyState());

  Future<void> loadListData(int id) async {
    emit(LoadingState());
    try {
    final result = await getSurveys(GetByIdParameters(id: id));
    emit(LoadedListState<SurveyEntity>(entities: result));
    }
    on LocalException catch (e, s) {
      logger.severe(e, s);
      emit(ErrorState(text: e.message));
      // print('$s');
    }
  }

}