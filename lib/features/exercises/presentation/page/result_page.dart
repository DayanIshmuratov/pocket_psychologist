import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/result_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_with_answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/result_state/result_bloc.dart';

import '../state/exercise_state/exercises_bloc.dart';

class ResultPage extends StatefulWidget {
  final CheckListEntity checkListEntity;

  const ResultPage({Key? key, required this.checkListEntity}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isExpanded = false;

  ///Toogle the box to expand or collapse
  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ResultBloc>()
        .add(LoadListEvent(id: widget.checkListEntity.id));
    context
        .read<QuestionWithAnswerBloc>()
        .add(LoadListEvent(id: widget.checkListEntity.id));
    // final lieResultBloc = context.read<LieResultBloc>().add(LoadListEvent(id: widget.checkListEntity.id));
    final exercisesBloc = context.read<ExercisesBloc>();

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 160,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: AppTitle(
              value: widget.checkListEntity.name,
            ),
            // background: Image.asset('assets/images/example_image.jpg'),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<ResultBloc, BaseState>(builder: (context, state) {
            if (state is LoadedListState<ResultEntity>) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSubtitle(
                          value:
                              "Ваш результат: ${_getResult(widget.checkListEntity.sum, state.entities)}",
                        ),
                        GestureDetector(
                          onTap: () {
                            _toogleExpand();
                          },
                          child: const AppText(value: 'Подробнее'),
                        ),
                        ExpandedSection(
                          expand: _isExpanded,
                          resultEntities: state.entities,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.entities.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: AppText(
                                            value:
                                                "${state.entities[index].result} : ${state.entities[index].minValue} - ${state.entities[index].maxValue}",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
        SliverToBoxAdapter(
          child:
              BlocBuilder<QuestionWithAnswerBloc, BaseState>(builder: (context, state) {
            if (state is LoadedListState<QuestionWithAnswerEntity>) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.entities.length,
                itemBuilder: (context, index) {
                  int answerId = state.entities[index].answerId;
                  context.read<AnswerBloc>().add(LoadListEvent(id: state.entities[index].id));
                  return Card(
                    child: ListTile(
                      title: AppSubtitle(
                          value:
                              '${index + 1}: ${state.entities[index].question}'),
                      subtitle: AppText(value: "Ответ: ${state.entities[index].answerName}"),

                      ),
                    );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
            // return SizedBox();
          }),
        )
      ],
    )
        // Column(
        //         children: [
        //           AppSubtitle(value: widget.checkListEntity.name),
        //           AppSubtitle(value: "Набрано баллов: ${widget.checkListEntity.sum}"),
        //           Expanded(
        //             child: BlocBuilder<ResultBloc, BaseState> (
        //               builder: (context, state) {
        //                 if (state is LoadedListState<ResultEntity>) {
        //                   return ListView.builder(
        //                       itemCount: state.entities.length,
        //                       itemBuilder: (context, index) {
        //                         return ListTile(
        //                           title: AppText(value: "${state.entities[index].result} : ${state.entities[index].minValue} - ${state.entities[index].maxValue}" ,),
        //                         );
        //                       }
        //                   );
        //                 } else return Center(child: CircularProgressIndicator(),);
        //               },
        //             ),
        //           ),
        //         ],
        //       )
        );
  }
}

String _findAnswer(List<AnswerEntity> entities, int answerId) {
  int i = 0;
  for (i; i < entities.length; i++) {
    if (answerId == entities[i].id) {
      break;
    }
  }
  return entities[i].answer;
}

String _getResult(int sum, List<ResultEntity> entities) {
  int i = 0;
  for (i; i < entities.length; i++) {
    if (entities[i].minValue <= sum && sum <= entities[i].maxValue) {
      break;
    }
  }
  return entities[i].result;
}

class ExpandedSection extends StatefulWidget {
  final List<ResultEntity> resultEntities;
  final Widget child;
  final bool expand;

  ExpandedSection(
      {this.expand = false, required this.child, required this.resultEntities});

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
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);
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
//        BlocBuilder<QuestionBloc, BaseState>(
//           builder: (context, state) {
//             if (state is LoadedListState<QuestionEntity>)
//               {return SliverFixedExtentList(
//                   itemExtent: 50,
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: state.entities.length,
//                         (context, index) {
//                       return ListTile(
//                         title: AppSubtitle(value: state.entities[index].question),
//                       );
//                     },
//                   ),
//                 );
//               } else return Center(child: CircularProgressIndicator());
//           }
//         )
