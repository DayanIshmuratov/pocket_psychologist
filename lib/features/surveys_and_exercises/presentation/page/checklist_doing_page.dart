import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/answer_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/survey_entity.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/lie_result_state/lie_result_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_counter_bloc/question_counter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';

class CheckListDoingPage extends StatefulWidget {
  final CheckListEntity checkListEntity;

  const CheckListDoingPage({super.key, required this.checkListEntity});

  @override
  State<CheckListDoingPage> createState() => _CheckListDoingPageState();
}

class _CheckListDoingPageState extends State<CheckListDoingPage> {
  @override
  void initState() {
    if (widget.checkListEntity.done == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _instructionDialog(context);
      });
    }
    super.initState();
  }
  // int _questionIndex = 0;
  Widget build(BuildContext context) {
    final questionBloc = context.read<QuestionCubit>();
    questionBloc.loadData(widget.checkListEntity.id);
    return BlocProvider(
      create: (context) =>
          QuestionCounterBloc(initialValue: widget.checkListEntity.done),
      child: Scaffold(
        appBar: AppBar(
          // flexibleSpace: AppSubtitle(value: checkListEntity.name),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: AppSubtitle(value: widget.checkListEntity.name)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.question_mark),
              onPressed: () {
                _instructionDialog(context);
              }
            ),
          ],
        ),
        body: BlocBuilder<QuestionCounterBloc, int>(
          builder: (context, state) {
            if (state == widget.checkListEntity.count) {
              return doneWidget(context);
            } else {
              return BlocBuilder<QuestionCubit, BaseState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedListState<QuestionEntity>) {
                  return doingWidget(state.entities, questionBloc, context);
                } else if (state is ErrorState) {
                  return Center(
                    child: Text(state.text),
                  );
                } else {
                  return const Center(child: Text("Неожиданная ошибка"));
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget doingWidget(List<QuestionEntity> questions, QuestionCubit questionBloc,
      BuildContext context) {
    final questionCounterBloc = context.watch<QuestionCounterBloc>();
    context
        .read<AnswerBloc>()
        .add(LoadListEvent(id: questions[questionCounterBloc.state].id));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              questionCounterBloc.state == 0
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {},
                      child: const Text("Предыдущий вопрос"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        questionCounterBloc.add(QuestionCounterDec());
                      },
                      child: const Text("Предыдущий вопрос"),
                    ),
              AppSubtitle(
                  value:
                      "${questionCounterBloc.state + 1} / ${widget.checkListEntity.count}")
            ],
          ),
          questions[questionCounterBloc.state].question != null ? SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppSubtitle(
                  value: questions[questionCounterBloc.state].question ?? '',
                ),
              ),
            ),
          ) : const SizedBox(height: 0,),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<AnswerBloc, BaseState>(builder: (context, state) {
            if (state is LoadedListState<AnswerEntity>) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.entities.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: state.entities[index].id ==
                                questions[questionCounterBloc.state].answerId
                            ? Colors.lightGreen
                            : Colors.white,
                        child: InkWell(
                          onTap: () {
                            questions[questionCounterBloc.state].answerId =
                                state.entities[index].id;
                            questionBloc.updateData(questions[questionCounterBloc.state]);
                            questionCounterBloc.add(QuestionCounterInc());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(value: state.entities[index].answer),
                          ),
                        ),
                      );
                    }),
              );
            }
            else if (state is ErrorState) {
              return Center(child: Text(state.text));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget doneWidget(BuildContext context) {
    final checklistBloc = context.read<CheckListBloc>().add(LoadListEvent());
    // checkListBloc.;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSubtitle(
              value: 'Вы успешно завершили опрос "${widget.checkListEntity.name}"',
              textAlign: TextAlign.center),
          BlocBuilder<CheckListBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadedListState) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'result_page',
                          arguments: state.entities[widget.checkListEntity.id - 1]);
                    },
                    child: const AppSubtitle(
                      value: 'Посмотреть результат',
                    ));
              } else
                return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Future<void> _instructionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder:(context) {
          return SimpleDialog(
            title: const AppTitle(
              value: 'Инструкция',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                        value:
                        widget.checkListEntity.instruction ?? 'Инструкцию не завезли =('),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Хорошо"),)
                  ],
                ),
              ),
            ],
          );
        },
    );
  }
}
