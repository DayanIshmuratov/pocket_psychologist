
import 'package:get_it/get_it.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/survey_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/question_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/repositories_impl/checklist_repository_Impl.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/survey_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/answer_usecases/get_answers.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/checklist_usecases/get_surveys.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/exercises_usecases/get_exercises.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/get_entity_lists.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/image_usecases/get_images.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/lie_result_usecases/get_lie_results.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_with_answer_usecases/get_questions_with_answer.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/result_usecases/get_results.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/image_state/image_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_with_answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/result_state/result_bloc.dart';

final sl = GetIt.instance;
void init() {
 // Bloc / Cubit
 // sl.registerFactory(() => QuestionBloc(getQuestions: sl()));
 sl.registerFactory(() => CheckListBloc(getCheckLists: sl(),));
 sl.registerFactory(() => ExercisesBloc(getExercises: sl()));

 sl.registerFactory(() => QuestionCubit(getQuestion: sl(), updateQuestion: sl()));
 sl.registerFactory(() => AnswerBloc(getAnswers: sl()));
 sl.registerFactory(() => ResultBloc(getResults: sl()));
 sl.registerFactory(() => LieResultBloc(getResults: sl()));
 sl.registerFactory(() => ImageBloc(getImages: sl()));
 sl.registerFactory(() => QuestionWithAnswerBloc(getQuestion: sl()));
 // Usecases
 sl.registerLazySingleton(() => GetCheckLists(repository: sl()));
 // sl.registerLazySingleton(() => UpdateCheckList(repository: sl()));
 sl.registerLazySingleton(() => GetQuestions(repository: sl()));
 sl.registerLazySingleton(() => UpdateQuestion(repository: sl()));
 sl.registerLazySingleton(() => GetAnswers(repository: sl()));
 sl.registerLazySingleton(() => GetResults(repository: sl()));
 sl.registerLazySingleton(() => GetLieResults(repository: sl()));
 sl.registerLazySingleton(() => GetImages(repository: sl()));
 sl.registerLazySingleton(() => GetExercises(repository: sl()));
 sl.registerLazySingleton(() => GetQuestionsWithAnswer(repository: sl()));
 // sl.registerLazySingleton(() => GetQuestions(repository: sl()));
 // Repository
 sl.registerLazySingleton<CheckListRepository>(() => CheckListRepositoryImpl(surveyLocalDataSource: sl()));
 sl.registerLazySingleton<CheckListLocalDataSource>(() => CheckListLocalDataSourceImpl(db: DBProvider.db));
 // sl.registerLazySingleton<QuestionLocalDataSource>(() => QuestionLocalDataSourceImpl(db: DBProvider.db));
 // Core
 // External

}