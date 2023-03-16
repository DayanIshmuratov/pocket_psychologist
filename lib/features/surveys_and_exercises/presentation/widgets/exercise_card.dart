import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';

import '../../domain/entities/exercise_entity.dart';


class ExerciseCard extends StatefulWidget {
  final ExercisesEntity entity;

  ExerciseCard({super.key, required this.entity});

  State<ExerciseCard> createState() {
    return _ExerciseCardState();
  }
}

class _ExerciseCardState extends State<ExerciseCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isDone = false;
  bool _isClosed = true;

  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'technique_images_page', arguments: widget.entity);
        },
        child: ListTile(
          title: AppSubtitle(
            value: widget.entity.name,
          ),
          // subtitle: Text(widget.entity.description ?? 'Нет описания',
          //     style: TextStyle(overflow: TextOverflow.ellipsis)),
        ),
      ),
    );
  }
}
