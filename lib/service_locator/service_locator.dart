import 'package:get_it/get_it.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/data/data_sources/remote_data_source.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/usecases/survey_usecases/get_surveys.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/answer_state/answer_cubit.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/result_state/result_cubit.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/survey_state/survey_cubit.dart';
import '../features/surveys_and_exercises/data/data_sources/survey_local_data_source.dart';
import '../features/surveys_and_exercises/data/repositories_impl/checklist_repository_Impl.dart';
import '../features/surveys_and_exercises/domain/repositories/survey_repository.dart';
import '../features/surveys_and_exercises/domain/usecases/answer_usecases/get_answers.dart';
import '../features/surveys_and_exercises/domain/usecases/exercises_usecases/get_exercises.dart';
import '../features/surveys_and_exercises/domain/usecases/image_usecases/get_images.dart';
import '../features/surveys_and_exercises/domain/usecases/lie_result_usecases/get_lie_results.dart';
import '../features/surveys_and_exercises/domain/usecases/question_usecases/get_questions.dart';
import '../features/surveys_and_exercises/domain/usecases/question_usecases/update_question.dart';
import '../features/surveys_and_exercises/domain/usecases/question_with_answer_usecases/get_questions_with_answer.dart';
import '../features/surveys_and_exercises/domain/usecases/result_usecases/get_results.dart';
import '../features/surveys_and_exercises/presentation/state/exercise_state/exercises_cubit.dart';
import '../features/surveys_and_exercises/presentation/state/image_state/image_cubit.dart';
import '../features/surveys_and_exercises/presentation/state/lie_result_state/lie_result_cubit.dart';
import '../features/surveys_and_exercises/presentation/state/question_state/question_cubit.dart';
import '../features/surveys_and_exercises/presentation/state/question_with_answer_cubit.dart';

final sl = GetIt.instance;
void init() {
 // Bloc / Cubit
 sl.registerFactory(() => SurveyCubit(getSurveys: sl(),));
 sl.registerFactory(() => ExercisesCubit(getExercises: sl()));
 sl.registerFactory(() => QuestionCubit(getQuestion: sl(), updateQuestion: sl()));
 sl.registerFactory(() => AnswerCubit(getAnswers: sl()));
 sl.registerFactory(() => ResultCubit(getResults: sl()));
 sl.registerFactory(() => LieResultCubit(getResults: sl()));
 sl.registerFactory(() => ImageCubit(getImages: sl()));
 sl.registerFactory(() => QuestionWithAnswerCubit(getQuestion: sl()));

 // Usecases
 sl.registerLazySingleton(() => GetSurveys(repository: sl()));
 sl.registerLazySingleton(() => GetQuestions(repository: sl()));
 sl.registerLazySingleton(() => UpdateQuestion(repository: sl()));
 sl.registerLazySingleton(() => GetAnswers(repository: sl()));
 sl.registerLazySingleton(() => GetResults(repository: sl()));
 sl.registerLazySingleton(() => GetLieResults(repository: sl()));
 sl.registerLazySingleton(() => GetImages(repository: sl()));
 sl.registerLazySingleton(() => GetExercises(repository: sl()));
 sl.registerLazySingleton(() => GetQuestionsWithAnswer(repository: sl()));

 // Repository
 sl.registerLazySingleton<SurveyRepository>(() => SurveyRepositoryImpl(surveyLocalDataSource: sl(), surveyRemoteDataSource: sl()));
 sl.registerLazySingleton<SurveyLocalDataSource>(() => SurveyLocalDataSourceImpl(db: DBProvider.db));
 sl.registerLazySingleton<SurveyRemoteDataSource>(() => SurveyRemoteDataSourceImpl(client: AppWriteProvider().client));
}