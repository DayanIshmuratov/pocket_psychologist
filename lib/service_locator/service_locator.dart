
import 'package:get_it/get_it.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/checklist_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/question_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/repositories_impl/checklist_repository_Impl.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/get_checklists.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/checklist_usecases/update_checklist.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/get_entity_lists.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/update_question.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';

final sl = GetIt.instance;
void init() {
 // Bloc / Cubit
 // sl.registerFactory(() => QuestionBloc(getQuestions: sl()));
 sl.registerFactory(() => CheckListBloc(getCheckLists: sl(), updateCheckList: sl()));
 sl.registerFactory(() => QuestionBloc(getQuestion: sl()));
 sl.registerFactory(() => AnswerBloc(updateAnswer: sl()));
 // Usecases
 sl.registerLazySingleton(() => GetCheckLists(repository: sl()));
 sl.registerLazySingleton(() => UpdateCheckList(repository: sl()));
 sl.registerLazySingleton(() => GetQuestion(repository: sl()));
 sl.registerLazySingleton(() => UpdateAnswer(repository: sl()));

 // sl.registerLazySingleton(() => GetQuestions(repository: sl()));
 // Repository
 sl.registerLazySingleton<CheckListRepository>(() => CheckListRepositoryImpl(checkListLocalDataSource: sl()));
 sl.registerLazySingleton<CheckListLocalDataSource>(() => CheckListLocalDataSourceImpl(db: DBProvider.db));
 // sl.registerLazySingleton<QuestionLocalDataSource>(() => QuestionLocalDataSourceImpl(db: DBProvider.db));
 // Core
 // External

}