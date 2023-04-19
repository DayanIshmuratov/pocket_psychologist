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
                  description: '''Тревога и депрессия являются весьма распространенными видами эмоций и переживаний сопровождающие жизнь человека в различных жизненных ситуациях. Будучи  негативными переживаниями, они могут существенно снижать качество жизни и негативно влиять эффективность деятельности.  Поэтому нужно качественно и  эффективно оценивать данные проявления эмоций в своей жизни. Вам предложено пройти тест и методику для выявления тревоги и депрессии. Результаты тестов не есть окончательная истина, и их объективность, как правило, зависит от вашей искренности при выборе ответов. После прохождения тестов мы предлагаем Вам, упражнения которые помогут вам справиться с тревогой и депрессией. ''',
                  page: 'checklists_page',
                ),
                SizedBox(
                  height: 16,
                ),
                SurveyAndExerciseCard(
                  title: 'Упражнения',
                  image: 'assets/images/common/techniques_image.jpg',
                  description: '''Мы собрали для вас пять самых эффективных упражнений, которые используют помогающие специалисты в процессе психокоррекции и которыми можно заниматься самостоятельно, чтобы уменьшить или совсем устранить разрушительное и/или справиться с психологическим дискомфортом.''',
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
