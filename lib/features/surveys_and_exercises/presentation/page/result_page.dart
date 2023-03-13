import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/answer_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/lie_results_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_with_answer_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/result_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/exercise_state/exercises_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_with_answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/result_state/result_bloc.dart';

class ResultPage extends StatefulWidget {
  final CheckListEntity checkListEntity;

  const ResultPage({Key? key, required this.checkListEntity}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isExpanded = false;

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
      appBar: AppBar(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppSubtitle(value: widget.checkListEntity.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<ResultBloc, BaseState>(builder: (context, state) {
                if (state is LoadedListState<ResultEntity>) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                              onPressed: () {
                                _lieResultDialog(
                                    context, widget.checkListEntity);
                              },
                              color: AppColors.mainColor,
                              // autofocus: true,
                              // focusNode: FocusNode(),
                              icon: Icon(Icons.sentiment_neutral),
                              tooltip: 'Результат лжи'),
                          Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      AppTitle(value: "${widget.checkListEntity
                                          .sum} из ${state.entities.last
                                          .maxValue}", color: Colors.white,),
                                      AppSubtitle(value: _getResult(
                                          widget.checkListEntity.sum,
                                          state.entities),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        color: Colors.white,)
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _toogleExpand();
                                },
                                child: const AppText(value: 'Подробнее'),
                              ),
                              ExpandedSection(
                                expand: _isExpanded,
                                resultEntities: state.entities,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                      // physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.entities.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: AppText(
                                            value:
                                            "${state.entities[index]
                                                .minValue} - ${state
                                                .entities[index]
                                                .maxValue} : ${state
                                                .entities[index].result}",
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              ),
              BlocBuilder<QuestionWithAnswerBloc, BaseState>(
                  builder: (context, state) {
                    if (state is LoadedListState<QuestionWithAnswerEntity>) {
                      return ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        physics: const ScrollPhysics(),
                        itemCount: state.entities.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: state.entities[index].question != null
                                ? ListTile(
                              title: AppSubtitle(
                                  value:
                                  '${index + 1}: ${state.entities[index]
                                      .question}'),
                              subtitle: AppText(
                                  value: "Ответ: ${state.entities[index]
                                      .answerName}"),

                            )
                                : ListTile(
                              title: AppSubtitle(
                                value: '${index + 1}: ${state.entities[index]
                                    .answerName}',
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // return SizedBox();
                  }),
            ],
          ),
        ),
      ),
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

String _getLieResult(int sum, List<LieResultEntity> entities) {
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

Future<void> _lieResultDialog(BuildContext context,
    CheckListEntity checkListEntity) {
  return showDialog(
    context: context,
    builder: (context) {
      context.read<LieResultBloc>().add(LoadListEvent(id: checkListEntity.id));
      return SimpleDialog(
        title: Center(
          child: const AppTitle(
            value: 'Результат лжи',
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: BlocBuilder<LieResultBloc, BaseState>(
                builder: (context, state) {
                  if (state is LoadedListState<LieResultEntity> &&
                      state.entities.isEmpty) {
                    return Center(child: AppSubtitle(
                        value: 'Недоступен для данного опроса'));
                  }
                  if (state is LoadedListState<LieResultEntity>) {
                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppTitle(value: "${checkListEntity.lieSum
                        } из ${state.entities.last.maxValue}",),
                        AppSubtitle(value: _getLieResult(
                            checkListEntity.lieSum, state.entities),
                            textAlign: TextAlign.center),
                        for (var i in state.entities)
                          AppText(
                            value:
                            "${i.minValue} - ${i.maxValue} : ${i.result}",
                          ),
                        // ListView.builder(
                        //   // shrinkWrap: true,
                        //   itemCount: state.entities.length,
                        //     itemBuilder: (context, index) {
                        //     return AppText(
                        //       value:
                        //       "${state.entities[index].minValue} - ${state.entities[index].maxValue} : ${state.entities[index].result}",
                        //     );
                        // }
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Хорошо"),)
                      ],
                    );
                  }
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else
                    return Center(child: AppSubtitle(value: "Ошибка",),
                    );
                }
            ),
          ),
        ],
      );
    },
  );
}

//  @override
//   Widget build(BuildContext context) {
//     context
//         .read<ResultBloc>()
//         .add(LoadListEvent(id: widget.checkListEntity.id));
//     context
//         .read<QuestionWithAnswerBloc>()
//         .add(LoadListEvent(id: widget.checkListEntity.id));
//     // final lieResultBloc = context.read<LieResultBloc>().add(LoadListEvent(id: widget.checkListEntity.id));
//     final exercisesBloc = context.read<ExercisesBloc>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: AppSubtitle(value: widget.checkListEntity.name),
//       ),
//         body: CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           expandedHeight: 160,
//           pinned: true,
//           flexibleSpace: FlexibleSpaceBar(
//             title: AppTitle(
//               value: widget.checkListEntity.name,
//             ),
//             // background: Image.asset('assets/images/example_image.jpg'),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: BlocBuilder<ResultBloc, BaseState>(builder: (context, state) {
//             if (state is LoadedListState<ResultEntity>) {
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     // mainAxisSize: MainAxisSize.min,
//                     children: [
//                       AppSubtitle(
//                         value:
//                             "Ваш результат: ${_getResult(widget.checkListEntity.sum, state.entities)}",
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _toogleExpand();
//                         },
//                         child: const AppText(value: 'Подробнее'),
//                       ),
//                       ExpandedSection(
//                         expand: _isExpanded,
//                         resultEntities: state.entities,
//                         child: SizedBox(
//                           height: 200,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   physics: ScrollPhysics(),
//                                   child: ListView.builder(
//                                     physics: NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: state.entities.length,
//                                     itemBuilder: (context, index) {
//                                       return ListTile(
//                                         title: AppText(
//                                           value:
//                                               "${state.entities[index].result} : ${state.entities[index].minValue} - ${state.entities[index].maxValue}",
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           }),
//         ),
//         SliverToBoxAdapter(
//           child:
//               BlocBuilder<QuestionWithAnswerBloc, BaseState>(builder: (context, state) {
//             if (state is LoadedListState<QuestionWithAnswerEntity>) {
//               return ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: state.entities.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: state.entities[index].question != null ? ListTile(
//                       title: AppSubtitle(
//                           value:
//                               '${index + 1}: ${state.entities[index].question}'),
//                       subtitle: AppText(value: "Ответ: ${state.entities[index].answerName}"),
//
//                       ) : ListTile(
//                       title: AppSubtitle(
//                         value: '${index + 1}: ${state.entities[index].answerName}',
//                       ),
//                     ),
//                     );
//                 },
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//             // return SizedBox();
//           }),
//         )
//       ],
//     ),
//     );
//   }
