import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';

import '../state/checklist_state/checklist_state.dart';
import '../widgets/checklist_card.dart';

class CheckListsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final _bloc = context.read<CheckListBloc>();
    _bloc.add(OnGetCheckListEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Чек листы"),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckListBloc, CheckListState>(
        builder: (BuildContext context, state) {
          if (state is CheckListStateEmpty) {
            return const Text("Empty");
          } else if (state is CheckListStateLoading) {
            return CircularProgressIndicator();
          } else if (state is CheckListStateLoaded) {
            return ListView.builder(
              itemCount: state.checkLists.length,
              itemBuilder: (context, index) {
                return CheckListCard(entity: state.checkLists[index]);
                //   ListTile(
                //   title: Text("${state.checkLists[index].name}"),
                //   subtitle: Text("${state.checkLists[index].id}"),
                // );
              },
            );
          } else if (state is CheckListStateError) {
            return Center(child: Text("${state.errorMessage}"));
          } else {
            return const Text("Неожиданная ошибка");
          }
        },
      ),
    );
  }
}
