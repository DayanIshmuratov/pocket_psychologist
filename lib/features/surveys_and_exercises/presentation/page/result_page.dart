import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/constants/app_colors/app_colors.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/lie_result_state/lie_result_cubit.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/presentation/state/question_with_answer_cubit.dart';

import '../../domain/entities/answer_entity.dart';
import '../../domain/entities/lie_results_entity.dart';
import '../../domain/entities/question_with_answer_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../state/bloc_states.dart';
import '../state/result_state/result_cubit.dart';
import '../state/survey_state/survey_cubit.dart';


class ResultPage extends StatefulWidget {
  final SurveyEntity surveyEntity;

  const ResultPage({Key? key, required this.surveyEntity}) : super(key: key);

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
    context.read<ResultCubit>().loadListData(widget.surveyEntity.id);
    context.read<QuestionWithAnswerCubit>().loadListData(widget.surveyEntity.id);
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppSubtitle(value: widget.surveyEntity.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<ResultCubit, BaseState>(
                builder: (context, state) {
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
                                    context, widget.surveyEntity);
                              },
                              color: AppColors.mainColor,
                              // autofocus: true,
                              // focusNode: FocusNode(),
                              icon: const Icon(Icons.sentiment_neutral),
                              tooltip: 'Результат лжи'),
                          Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      AppTitle(value: "${widget.surveyEntity
                                          .sum} из ${state.entities.last
                                          .maxValue}", color: Colors.white,),
                                      AppSubtitle(value: _getResult(
                                          widget.surveyEntity.sum,
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
                }
                else if (state is ErrorState) {
                  return Center(child: AppTitle(value: state.text));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              ),
              BlocBuilder<QuestionWithAnswerCubit, BaseState>(
                  builder: (context, state) {
                    if (state is LoadedListState<QuestionWithAnswerEntity>) {
                      return ListView.builder(
                        shrinkWrap: true,
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
                  }
                  ),
            ],
          ),
        ),
      ),
    );
  }
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
    SurveyEntity surveyEntity) {
  return showDialog(
    context: context,
    builder: (context) {
      context.read<LieResultCubit>().loadListData(0);
      return SimpleDialog(
        title: const Center(
          child: AppTitle(
            value: 'Результат лжи',
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<LieResultCubit, BaseState>(
                builder: (context, state) {
                  if (state is LoadedListState<LieResultEntity> &&
                      state.entities.isEmpty) {
                    return const Center(child: AppSubtitle(
                        value: 'Недоступен для данного опроса'));
                  }
                  if (state is LoadedListState<LieResultEntity>) {
                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppTitle(value: "${surveyEntity.lieSum
                        } из ${state.entities.last.maxValue}",),
                        AppSubtitle(value: _getLieResult(
                            surveyEntity.lieSum, state.entities),
                            textAlign: TextAlign.center),
                        for (var i in state.entities)
                          AppText(
                            value:
                            "${i.minValue} - ${i.maxValue} : ${i.result}",
                          ),
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
                  else {
                    return const Center(child: AppSubtitle(value: "Ошибка",),
                    );
                  }
                }
            ),
          ),
        ],
      );
    },
  );
}

