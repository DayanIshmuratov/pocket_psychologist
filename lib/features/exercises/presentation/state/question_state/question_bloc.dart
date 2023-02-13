// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
// import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
// import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
// import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';
//
// class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
//   final GetQuestions getQuestions;
//   QuestionBloc({required this.getQuestions}) : super(QuestionStateEmpty()) {
//     on<OnQuestionEvent>((OnQuestionEvent event, Emitter<QuestionState> emit) async {
//         emit(QuestionStateLoading());
//       try {
//         final result = await getQuestions(event.nameId);
//         emit(QuestionStateLoaded(result)); }
//       catch (e) {
//         emit(QuestionStateError(e.toString()));
//         // print('$s');
//       }
//     }
//     );
//   }
//
// }