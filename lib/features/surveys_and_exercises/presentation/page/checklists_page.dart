import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/to_delete_later/clear_db.dart';
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/features/exercises/data/data_sources/survey_local_data_source.dart';
import 'package:pocket_psychologist/features/exercises/data/repositories_impl/checklist_repository_Impl.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/answer_usecases/get_answers.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/question_usecases/get_questions.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/image_state/image_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_with_answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/result_state/result_bloc.dart';
import 'package:pocket_psychologist/service_locator/service_locator.dart';

import '../state/checklist_state/checklist_state.dart';
import '../widgets/checklist_card.dart';

class CheckListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CheckListBloc>().add(LoadListEvent());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.traffic_outlined),
            onPressed: () {
              ResetDB().reset();
            },
          ),
        ],
        title: const AppSubtitle(value: 'Опросы'),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckListBloc, BaseState>(
        builder: (BuildContext context, state) {
          if (state is EmptyState) {
            return const Center(child: AppTitle(
                value: 'Нет данных. Обратитесь к создателям приложения'));
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedListState<CheckListEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return CheckListCard(entity: state.entities[index]);
              },
            );
          } else if (state is ErrorState) {
            return Center(child: AppTitle(value: state.text,));
          } else {
            return const Center(child: Text("Неожиданная ошибка"));
          }
        },
      ),
    );
  }
}
