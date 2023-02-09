import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/usecases/get_check_list/get_check_list.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state.dart';
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
      appBar: AppBar(
        title: Text("Упражнения"),
        centerTitle: true,
      ),
      body: ExerciseView(),
    );
  }
}
//
// class ExercisesPage extends StatefulWidget {
//   State<ExercisesPage> createState() {
//     return _ExercisesPageState();
//   }
// }
//
// class _ExercisesPageState extends State<ExercisesPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     final _bloc = context.read<CheckListBloc>();
//     _bloc.add(OnCheckListEvent());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Упражнения"),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<CheckListBloc, CheckListState>(
//         builder: (BuildContext context, state) {
//           if (state is CheckListStateEmpty) {
//             return Text("Empty");
//           } else if (state is CheckListStateLoading) {
//             return CircularProgressIndicator();
//           } else if (state is CheckListStateLoaded) {
//             return ListView.builder(
//               itemCount: state.checkLists.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text("${state.checkLists[index].name}"),
//                   subtitle: Text("${state.checkLists[index].id}"),
//                 );
//               },
//             );
//           }
//           return Text("Error");
//         },
//       ),
//     );
//   }
// }
