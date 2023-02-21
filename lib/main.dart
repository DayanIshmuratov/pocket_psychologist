import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/checklist_doing_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/checklists_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/tests_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/main_page/main_page.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart' as di;
import 'package:pocket_psychologist/service_locator/service_locator.dart';

void main() {
  runApp(MyApp());
  di.init();
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CheckListBloc>(create: (context) => sl<CheckListBloc>()),
      BlocProvider<QuestionBloc>(create: (context) => sl<QuestionBloc>()),
      BlocProvider<AnswerBloc>(create: (context) => sl<AnswerBloc>()),
    ], child: MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'checklists_page' : return MaterialPageRoute(builder: (context) => CheckListsPage(),);
          case 'tests_page' : return MaterialPageRoute(builder: (context) => TestsPage(),);
          case 'checklist_doing_page' :
            final CheckListEntity entity = settings.arguments as CheckListEntity;
            return MaterialPageRoute(builder: (context) => CheckListDoingPage(checkListEntity: entity,));
        }
      },
      home: MainPage(),
    ));
  }
}
