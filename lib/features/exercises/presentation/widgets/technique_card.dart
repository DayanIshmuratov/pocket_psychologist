import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/exercise_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
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

  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 1),
  //     vsync: this,
  //     // vsync: this,
  //   );
  //   _animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.elasticInOut,
  //   );
  // }

  // _toggleContainer() {
  //   print(_animation.status);
  //   if (_animation.status != AnimationStatus.completed) {
  //     _controller.forward();
  //   } else {
  //     _controller.animateBack(0, duration: Duration(seconds: 1));
  //   }
  // }

  // final entity = widget.entity;
  bool _isClosed = true;

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'technique_images_page', arguments: widget.entity);
              },
              title: AppSubtitle(
                value: widget.entity.name,
              ),
              // subtitle: Text(widget.entity.description ?? 'Нет описания',
              //     style: TextStyle(overflow: TextOverflow.ellipsis)),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  ExpandedSection(
      {this.expand = false, required this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    Animation<double> curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
