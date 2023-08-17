import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import '../../domain/entities/exercise_entity.dart';


class ExerciseCard extends StatefulWidget {
  final ExercisesEntity entity;

  ExerciseCard({super.key, required this.entity});

  @override
  State<ExerciseCard> createState() {
    return _ExerciseCardState();
  }
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'exercise_images_page', arguments: widget.entity);
        },
        child: ListTile(
          title: AppSubtitle(
            value: widget.entity.name,
          ),
        ),
      ),
    );
  }
}