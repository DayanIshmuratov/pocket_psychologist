import 'dart:async';

import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/constants/app_colors/app_theme.dart';
import 'package:pocket_psychologist/core/bloc_observer/bloc_observer.dart';
import 'package:pocket_psychologist/core/error_handler/error_handler.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/features/auth/presentation/page/password_recovery_page.dart';
import 'package:pocket_psychologist/features/auth/presentation/page/sign_in_page.dart';
import 'package:pocket_psychologist/features/chat/presentation/state/chat_cubit.dart';
import 'package:pocket_psychologist/features/profile/page/edit_profile_page.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/page/exercises_image_page.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart' as di;
import 'package:pocket_psychologist/service_locator/service_locator.dart';
import 'common/greeting/greeting.dart';
import 'features/auth/presentation/state/auth_cubit.dart';
import 'features/surveys_and_exercises/domain/entities/exercise_entity.dart';
import 'features/surveys_and_exercises/domain/entities/survey_entity.dart';
import 'features/surveys_and_exercises/presentation/page/survey_doing_page.dart';
import 'features/surveys_and_exercises/presentation/page/surveys_page.dart';
import 'features/surveys_and_exercises/presentation/page/result_page.dart';
import 'features/surveys_and_exercises/presentation/page/exercises_images_page.dart';
import 'features/surveys_and_exercises/presentation/page/exercises_page.dart';
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
    runApp(const Wrapper());
    di.init();
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
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
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
                case 'exercises_page':
                  return MaterialPageRoute(
                      builder: (context) => ExercisesPage());
                case 'exercise_images_page':
                  final ExercisesEntity entity =
                  settings.arguments as ExercisesEntity;
                  return MaterialPageRoute(
                      builder: (context) =>
                          TechniqueImagesPage(
                            entity: entity,
                          ));
                case 'surveys_page':
                  return MaterialPageRoute(
                    builder: (context) => SurveysPage(),
                  );
                case 'survey_doing_page':
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
                  return MaterialPageRoute(builder: (context) => const SignInPage());
                case 'image_page' :
                  final path = settings.arguments as String;
                  return MaterialPageRoute(builder: (context) => ImagePage(path: path));
                case 'password_recovery_page' :
                  final data = settings.arguments as Map<String, Object>;
                  return MaterialPageRoute(builder: (context) => PasswordRecoveryPage(authCubit: data['authCubit'] as AuthCubit, email: data['email'] as String));
                case 'edit_profile_page' :
                  final authCubit = settings.arguments as AuthCubit;
                  return MaterialPageRoute(builder: (context) => EditProfilePage(authCubit: authCubit,));
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
            home: AnimatedSplashScreen(
              splashIconSize: 200,
                duration: 5000,
                splash: Image.asset('assets/images/common/splash_screen.png', fit: BoxFit.fill,),
                nextScreen: GreetPage(),
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.bottomToTop,
                backgroundColor: Colors.white),
          );
        },
      ),
    );
  }
}
