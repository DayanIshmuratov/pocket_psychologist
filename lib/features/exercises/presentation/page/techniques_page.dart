import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/widgets/technique_card.dart';

import '../state/checklist_state/checklist_state.dart';
import '../widgets/checklist_card.dart';

class TechniquesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExercisesBloc>();
    bloc.add(LoadListEvent());
    return Scaffold(
      appBar: AppBar(
        title: const AppSubtitle(value: 'Опросы'),
        centerTitle: true,
      ),
      body: BlocBuilder<ExercisesBloc, BaseState>(
        builder: (BuildContext context, state) {
          if (state is EmptyState) {
            return const Center(child: AppTitle(value: 'Нет данных. Обратитесь к создателям приложения'));
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedListState<ExercisesEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return TechniqueCard(entity: state.entities[index]);
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
