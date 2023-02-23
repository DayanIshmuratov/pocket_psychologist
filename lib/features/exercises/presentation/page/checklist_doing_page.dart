import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/answer_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/answer_state/answer_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_events.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/bloc_states.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class CheckListDoingPage extends StatefulWidget {
  final CheckListEntity checkListEntity;

  const CheckListDoingPage({super.key, required this.checkListEntity});

  @override
  State<CheckListDoingPage> createState() => _CheckListDoingPageState();
}

class _CheckListDoingPageState extends State<CheckListDoingPage> {
  int _questionIndex = 0;

  void initState() {
    super.initState();
    _questionIndex = widget.checkListEntity.done;
  }

  Widget build(BuildContext context) {
    final questionBloc = context.read<QuestionBloc>();
    final answerBloc = context.read<AnswerBloc>();
    final checklistBloc = context.read<CheckListBloc>();
    questionBloc.add(LoadEvent(id: widget.checkListEntity.id));
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          // leading: IconButton(onPressed: () {
          //   Navigator.pop(context);
          // }, icon: Icon(Icons.arrow_back)),
          title: Text("Упражнения"),
          centerTitle: true,
        ),
        body: (_questionIndex < widget.checkListEntity.count) &&
                _questionIndex != -1
            ? BlocBuilder<QuestionBloc, BaseState>(builder: (context, state) {
                if (state is LoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LoadedListState<QuestionEntity>) {
                  return doingWidget(
                      state.entities, questionBloc, checklistBloc, answerBloc);
                } else if (state is ErrorState) {
                  return Center(
                    child: Text(state.text),
                  );
                } else {
                  return Center(child: Text("Неожиданная ошибка"));
                }
              })
            : doneWidget());
  }

  Widget doingWidget(List<QuestionEntity> questions, QuestionBloc questionBloc,
      CheckListBloc checkListBloc, AnswerBloc answerBloc) {
    answerBloc.add(LoadEvent(id: questions[_questionIndex].id));
    return Column(
      children: [
        _questionIndex == 0
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {},
                child: Text("Назад"),
              )
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    _questionIndex--;
                  });
                },
                child: Text("Назад"),
              ),
        Card(
          child: Text(
            questions[_questionIndex].question ?? '',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        BlocBuilder<AnswerBloc, BaseState>(builder: (context, state) {
          if (state is LoadedListState<AnswerEntity>) {
            return Expanded(
              child: ListView.builder(
                  itemCount: state.entities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        questions[_questionIndex].answerId =
                            state.entities[index].id;
                        questionBloc.add(
                            UpdateEvent(entity: questions[_questionIndex]));
                        _questionIndex++;
                        setState(() {});
                      },
                      child: Card(
                        child: Text(state.entities[index].answer),
                        color: state.entities[index].id ==
                                questions[_questionIndex].answerId
                            ? Colors.lightGreen
                            : Colors.white,
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        // GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         widget.questions.answer[_questionIndex] = 1;
        //         _questionIndex++;
        //       });
        //     },
        //     child: Card(child: Text('Верно'), color: widget.questions.answer[_questionIndex] == 1 ? Colors.lightGreen : Colors.white,)),
        // SizedBox(
        //   height: 8,
        // ),
        // GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         widget.questions.answer[_questionIndex] = 2;
        //         _questionIndex++;
        //         //result[_questionIndex].add(1)
        //       });
        //     },
        //     child: Card(child: Text('Неверно'), color: widget.questions.answer[_questionIndex] == 2 ? Colors.lightGreen : Colors.white  ,)),
        // SizedBox(
        //   height: 8,
        // ),
        // GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         widget.questions.answer[_questionIndex] = 3;
        //         _questionIndex++;
        //         //result[_questionIndex].add(1)
        //       });
        //     },
        //     child: Card(child: Text('Не знаю'), color: widget.questions.answer[_questionIndex] == 3 ? Colors.lightGreen : Colors.white  ,)),
      ],
    );
  }

  Widget doneWidget() {
    return Column(
      children: [
        Text('Вы завершили чек лист'),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Идет сохранение результата в БД
            },
            child: Text('Посмотреть результаты')),
      ],
    );
  }
}
