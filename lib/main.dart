import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/checklists_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/exercises_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/page/tests_page.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_bloc.dart';
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
      BlocProvider<CheckListBloc>(create: (context) => sl<CheckListBloc>())
    ], child: MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'checklists_page' : return MaterialPageRoute(builder: (context) => CheckListsPage(),);
          case 'tests_page' : return MaterialPageRoute(builder: (context) => TestsPage(),);
        }
      },
      home: MainPage(),
    ));
  }
}
