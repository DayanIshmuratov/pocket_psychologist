import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class TechniqueCard extends StatefulWidget {
  final ExercisesEntity entity;

  TechniqueCard({super.key, required this.entity});

  State<TechniqueCard> createState() {
    return _TechniqueCardState();
  }
}

class _TechniqueCardState extends State<TechniqueCard> with TickerProviderStateMixin {
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
