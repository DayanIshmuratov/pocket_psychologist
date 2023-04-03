import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';

import '../../domain/entities/survey_entity.dart';
import '../state/survey_state/survey_cubit.dart';

class CheckListCard extends StatefulWidget {
  final SurveyEntity entity;

  const CheckListCard({super.key, required this.entity});

  @override
  State<CheckListCard> createState() {
    return _CheckListCardState();
  }
}

class _CheckListCardState extends State<CheckListCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      // vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _isDone = widget.entity.done == widget.entity.count;
  }

  _toggleContainer() {
    print(_animation.status);
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(seconds: 1));
    }
  }

  // final entity = widget.entity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _toggleContainer();
            },
            child: ListTile(
              title: AppSubtitle(
                value: widget.entity.name,
              ),
              trailing: _isDone
                  ? IconButton(
                      icon: Icon(Icons.done, color: Colors.green),
                      onPressed: () {},
                      tooltip: "Вы уже прошли данный чек лист",
                    )
                  : IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {},
                      tooltip: "Вы еще не прошли данный чек лист",
                    ),
              // subtitle: Text(widget.entity.description ?? 'Нет описания',
              //     style: TextStyle(overflow: TextOverflow.ellipsis)),
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text(widget.entity.description ?? "Нет описания"),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text('${widget.entity.questions.answer.indexOf(0) == -1 ? widget.entity.questions.answer.length : widget.entity.questions.answer.indexOf(0)}/${widget.entity.questions.answer.length}'),
                      Text('${widget.entity.done}/${widget.entity.count}'),
                      ElevatedButton(
                        onPressed: () async {
                          if (_isDone) {
                            await Navigator.pushNamed(context, 'result_page',
                                arguments: widget.entity);
                          } else {
                            await Navigator.pushNamed(
                                context, 'checklist_doing_page',
                                arguments: widget.entity);
                            context.read<SurveyCubit>().loadListData(0);
                          }
                          setState(() {});
                        },
                        child: _isDone ? Text('Результат') : Text('Выполнить'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
