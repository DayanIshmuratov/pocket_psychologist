import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';

import '../../domain/entities/exercise_entity.dart';
import '../../domain/entities/image_entity.dart';
import '../state/bloc_states.dart';
import '../state/image_state/image_cubit.dart';

class TechniqueImagesPage extends StatelessWidget {
  final ExercisesEntity entity;
  const TechniqueImagesPage({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ImageCubit>().loadListData(entity.id);
    return Scaffold(
      appBar: AppBar(
        title: AppSubtitle(value: '${entity.name}'),
      ),

      body: BlocBuilder<ImageCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadedListState<ImageEntity>) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'image_page', arguments: state.entities[index].path);
                  },
                  child: Card(child:
                  Image.asset(state.entities[index].path),
                 ),
                );
              }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
