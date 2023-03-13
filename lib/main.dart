import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/core/bloc_observer/bloc_observer.dart';
import 'package:pocket_psychologist/core/error_handler/error_handler.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/technique_images_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/checklist_doing_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/checklists_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/result_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/techniques_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/tests_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/image_state/image_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_with_answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/result_state/result_bloc.dart';
import 'package:pocket_psychologist/main_page/main_page.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart' as di;
import 'package:pocket_psychologist/service_locator/service_locator.dart';

void main() async {
  Bloc.observer = MainBlocObserver();

  await runZonedGuarded<Future<void>>(() async {
    initLogger();
    logger.info('Start main');
    runApp(MyApp());
    di.init();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
      ),
    );
    ErrorHandler.init();
  }, ErrorHandler.recordError
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnswerBloc>(create: (context) => sl<AnswerBloc>(),),
        BlocProvider<ResultBloc>(create: (context) => sl<ResultBloc>()),
        BlocProvider<LieResultBloc>(create: (context) => sl<LieResultBloc>()),
        BlocProvider<ImageBloc>(create: (context) => sl<ImageBloc>()),
        BlocProvider<QuestionWithAnswerBloc>(create: (context) => sl<QuestionWithAnswerBloc>(),),
        BlocProvider<QuestionCubit>(create: (context) => sl<QuestionCubit>()),
        BlocProvider<CheckListBloc>(
          create: (context) => sl<CheckListBloc>(),
        ),
        BlocProvider<ExercisesBloc>(
          create: (context) => sl<ExercisesBloc>(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case 'techniques_page' : return MaterialPageRoute(builder: (context) => TechniquesPage());
            case 'technique_images_page' :
              final ExercisesEntity entity = settings.arguments as ExercisesEntity;
              return MaterialPageRoute(builder: (context) => TechniqueImagesPage(entity: entity,));
            case 'checklists_page' : return MaterialPageRoute(builder: (context) => CheckListsPage(),);
            case 'tests_page' : return MaterialPageRoute(builder: (context) => TestsPage(),);
            case 'checklist_doing_page' :
              final CheckListEntity entity = settings.arguments as CheckListEntity;
              return MaterialPageRoute(builder: (context) => CheckListDoingPage(checkListEntity: entity,));
            case 'result_page' :
              final CheckListEntity checkListEntity = settings.arguments as CheckListEntity;
              return MaterialPageRoute(builder: (context) => ResultPage(checkListEntity: checkListEntity));
          }
        },

        // color: AppColors.mainColor,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColors.mainColor,
          ),
          // colorScheme: ColorScheme(
          //   primary: AppColors.mainColor,
          // ),
          fontFamily: "Nunito",
        ),
        home: MainPage(),
      ),
    );
  }
}
