import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/constants/app_colors/app_theme.dart';
import 'package:pocket_psychologist/core/bloc_observer/bloc_observer.dart';
import 'package:pocket_psychologist/core/error_handler/error_handler.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/auth/presentation/page/sign_in_page.dart';
import 'package:pocket_psychologist/main_page/main_page.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart' as di;
import 'package:pocket_psychologist/service_locator/service_locator.dart';
import 'core/server/appwrite.dart';
import 'features/auth/presentation/state/auth_cubit.dart';
import 'features/surveys_and_exercises/domain/entities/exercise_entity.dart';
import 'features/surveys_and_exercises/domain/entities/survey_entity.dart';
import 'features/surveys_and_exercises/presentation/page/survey_doing_page.dart';
import 'features/surveys_and_exercises/presentation/page/surveys_page.dart';
import 'features/surveys_and_exercises/presentation/page/result_page.dart';
import 'features/surveys_and_exercises/presentation/page/exercises_images_page.dart';
import 'features/surveys_and_exercises/presentation/page/exercises_page.dart';
import 'features/surveys_and_exercises/presentation/page/tests_page.dart';
import 'features/surveys_and_exercises/presentation/state/answer_state/answer_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/exercise_state/exercises_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/image_state/image_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/lie_result_state/lie_result_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/question_state/question_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/question_with_answer_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/result_state/result_cubit.dart';
import 'features/surveys_and_exercises/presentation/state/survey_state/survey_cubit.dart';

void main() async {
  Bloc.observer = MainBlocObserver();
  await runZonedGuarded<Future<void>>(() async {
    initLogger();
    logger.info('Start main');
    runApp(Wrapper());
    di.init();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: AppColors.mainColor,
    //   ),
    // );
    ErrorHandler.init();
  }, ErrorHandler.recordError);
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppTheme(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(AppWriteProvider().client),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnswerCubit>(
          create: (context) => sl<AnswerCubit>(),
        ),
        BlocProvider<ResultCubit>(create: (context) => sl<ResultCubit>()),
        BlocProvider<LieResultCubit>(create: (context) => sl<LieResultCubit>()),
        BlocProvider<ImageCubit>(create: (context) => sl<ImageCubit>()),
        BlocProvider<QuestionWithAnswerCubit>(
          create: (context) => sl<QuestionWithAnswerCubit>(),
        ),
        BlocProvider<QuestionCubit>(create: (context) => sl<QuestionCubit>()),
        BlocProvider<SurveyCubit>(
          create: (context) => sl<SurveyCubit>(),
        ),
        BlocProvider<ExercisesCubit>(
          create: (context) => sl<ExercisesCubit>(),
        ),
      ],
      child: BlocBuilder<AppTheme, AppThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case 'techniques_page':
                  return MaterialPageRoute(
                      builder: (context) => ExercisesPage());
                case 'technique_images_page':
                  final ExercisesEntity entity =
                  settings.arguments as ExercisesEntity;
                  return MaterialPageRoute(
                      builder: (context) =>
                          TechniqueImagesPage(
                            entity: entity,
                          ));
                case 'checklists_page':
                  return MaterialPageRoute(
                    builder: (context) => SurveysPage(),
                  );
                case 'tests_page':
                  return MaterialPageRoute(
                    builder: (context) => TestsPage(),
                  );
                case 'checklist_doing_page':
                  final SurveyEntity entity =
                  settings.arguments as SurveyEntity;
                  return MaterialPageRoute(
                      builder: (context) =>
                          SurveyDoingPage(
                            surveyEntity: entity,
                          ));
                case 'result_page':
                  final SurveyEntity entity =
                  settings.arguments as SurveyEntity;
                  return MaterialPageRoute(
                      builder: (context) => ResultPage(surveyEntity: entity));
                case 'sign_in_page':
                  return MaterialPageRoute(builder: (context) => SignInPage());
              }
            },
            // color: AppColors.mainColor,
            theme: ThemeData(
              primaryColor: state.mainColor,
              secondaryHeaderColor: state.secondaryColor,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: state.mainColor as MaterialColor,
              ),
              fontFamily: "Nunito",
            ),
            home: MainPage(),
          );
        },
      ),
    );
  }
}
