import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/survey_state/survey_cubit.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart';
import '../state/bloc_states.dart';
import '../widgets/survey_card.dart';

class SurveysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<SurveyCubit>().loadListData(0);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.traffic_outlined),
            onPressed: () {
              DBProvider.resetDB();
            },
          ),
        ],
        title: const AppSubtitle(value: 'Опросы'),
        centerTitle: true,
      ),
      body: BlocBuilder<SurveyCubit, BaseState>(
        builder: (BuildContext context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedListState<SurveyEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return CheckListCard(entity: state.entities[index]);
              },
            );
          } else if (state is ErrorState) {
            return Center(
                child: AppTitle(
              value: state.text,
            ));
          } else {
            return const Center(child: Text("Неожиданная ошибка"));
          }
        },
      ),
    );
  }
}
