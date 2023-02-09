
import 'package:get_it/get_it.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/repositories_impl/checklist_repository_Impl.dart';
import 'package:pocket_psychologist/features/exercises/domain/repositories/checklist_repository.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/get_check_list/get_check_list.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_bloc.dart';

final sl = GetIt.instance;
void init() {
 // Bloc / Cubit
 sl.registerFactory(() => CheckListBloc(getCheckLists: sl()));
 // Usecases
 sl.registerLazySingleton(() => GetCheckLists(repository: sl()));
 // Repository
 sl.registerLazySingleton<CheckListRepository>(() => CheckListRepositoryImpl(checkListLocalDataSource: sl()));
 sl.registerLazySingleton<CheckListLocalDataSource>(() => CheckListLocalDataSourceImpl(db: DBProvider.db));
 // Core
 // External

}