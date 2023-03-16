import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import '../../domain/entities/exercise_entity.dart';
import '../state/bloc_states.dart';
import '../state/exercise_state/exercises_cubit.dart';
import '../widgets/exercise_card.dart';
import '../widgets/survey_card.dart';

class ExercisesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExercisesCubit>();
    bloc.loadListData(0);
    return Scaffold(
      appBar: AppBar(
        title: const AppSubtitle(value: 'Опросы'),
        centerTitle: true,
      ),
      body: BlocBuilder<ExercisesCubit, BaseState>(
        builder: (BuildContext context, state) {
          if (state is EmptyState) {
            return const Center(child: AppTitle(value: 'Нет данных. Обратитесь к создателям приложения'));
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedListState<ExercisesEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return ExerciseCard(entity: state.entities[index]);
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
