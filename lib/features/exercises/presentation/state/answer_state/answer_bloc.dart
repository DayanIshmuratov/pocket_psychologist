import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';

class AnswerBloc extends Bloc<BaseEvent, BaseState> {
  final UpdateAnswer updateAnswer;
  AnswerBloc({required this.updateAnswer}) : super(EmptyState()) {
    on<UpdateEvent<AnswerEntity>> ((UpdateEvent<AnswerEntity> event, Emitter<BaseState> emit) async {
      await updateAnswer(event.entity);

    }
    );

  }
}