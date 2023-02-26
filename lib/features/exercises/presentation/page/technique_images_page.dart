import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/image_state/image_bloc.dart';

class TechniqueImagesPage extends StatelessWidget {
  final ExercisesEntity entity;
  const TechniqueImagesPage({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ImageBloc>().add(LoadListEvent(id : entity.id));
    return Scaffold(
      appBar: AppBar(
        title: AppSubtitle(value: '${entity.name}'),
      ),

      body: BlocBuilder<ImageBloc, BaseState>(
        builder: (context, state) {
          if (state is LoadedListState<ImageEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return Card(child: InteractiveViewer(
                    panEnabled: true, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    child: Image.asset(state.entities[index].path)));
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
