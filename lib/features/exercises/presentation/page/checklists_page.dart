import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';

import '../state/checklist_state/checklist_state.dart';
import '../widgets/checklist_card.dart';

class CheckListsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final _bloc = context.read<CheckListBloc>();
    _bloc.add(LoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Чек листы"),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckListBloc, BaseState>(
        builder: (BuildContext context, state) {
          if (state is EmptyState) {
            return const Text("Empty");
          } else if (state is LoadingState) {
            return CircularProgressIndicator();
          } else if (state is LoadedListState<CheckListEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return CheckListCard(entity: state.entities[index]);
                //   ListTile(
                //   title: Text("${state.checkLists[index].name}"),
                //   subtitle: Text("${state.checkLists[index].id}"),
                // );
              },
            );
          } else if (state is ErrorState) {
            return Center(child: Text("${state.text}"));
          } else {
            return const Text("Неожиданная ошибка");
          }
        },
      ),
    );
  }
}
