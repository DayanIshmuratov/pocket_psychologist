import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_state.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/widgets/exercise_card.dart';
import 'package:pocket_psychologist/features/exercises/presentation/widgets/exercise_view.dart';

import '../../../../service_locator/service_locator.dart';

class ExercisesPage extends StatefulWidget {
  State<ExercisesPage> createState() {
    return _ExercisesPageState();
  }
}

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Упражнения"),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                ExerciseCard(
                  title: 'Опросы',
                  image: 'assets/images/common/polls_image.jpg',
                  description: "Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание ",
                  page: 'checklists_page',
                ),
                SizedBox(
                  height: 16,
                ),
                ExerciseCard(
                  title: 'Упражнения',
                  image: 'assets/images/common/techniques_image.jpg',
                  description: "Описание описание Описание описание описание описание описание описание Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание ",
                  page: 'techniques_page',),
                // ExerciseSecondCard(),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
