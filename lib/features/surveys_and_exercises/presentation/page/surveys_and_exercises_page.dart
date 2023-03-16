import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import '../../../../service_locator/service_locator.dart';
import '../widgets/survey_and_exercise_card.dart';

class SurveysAndExercisesPage extends StatefulWidget {
  State<SurveysAndExercisesPage> createState() {
    return _SurveysAndExercisesPageState();
  }
}

class _SurveysAndExercisesPageState extends State<SurveysAndExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                SurveyAndExerciseCard(
                  title: 'Опросы',
                  image: 'assets/images/common/polls_image.jpg',
                  description: "Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание Описание описание ",
                  page: 'checklists_page',
                ),
                SizedBox(
                  height: 16,
                ),
                SurveyAndExerciseCard(
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
