import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int _questionIndex = 1;
  void initState() {
    super.initState();
    _questionIndex = widget.checkListEntity.done + 1;
  }


  Widget build(BuildContext context) {
    final questionBloc = context.read<QuestionBloc>();
    final answerBloc = context.read<AnswerBloc>();
    final checklistBloc = context.read<CheckListBloc>();
    questionBloc.add(LoadEvent(id: widget.checkListEntity.id, secondId: _questionIndex));
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: () {
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back)),
        title: Text("Упражнения"),
        centerTitle: true,
      ),
      body: (_questionIndex <= widget.checkListEntity.count) && _questionIndex != 0
                ?
      BlocBuilder<QuestionBloc, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
          }
          else if (state is LoadedState<QuestionEntity>) {
            return doingWidget(state.entity, answerBloc, checklistBloc);
          } else if (state is ErrorState) {
            return Center(child: Text(state.text),);
          }
          else {
            return Center(child: Text("Неожиданная ошибка"));
          }
        }
      )
                : doneWidget()
  );
  }

  Widget doingWidget(QuestionEntity question, AnswerBloc answerBloc, CheckListBloc checkListBloc) {
    return Column(
      children: [
        _questionIndex == 1
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
            question.question ?? '',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: question.answers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    question.answers[index].isChoosen = 1;
                    await answerBloc.updateAnswer(question.answers[index]);
                    widget.checkListEntity.done++;
                    widget.checkListEntity.sum += question.answers[index].value;
                    await checkListBloc.updateCheckList(widget.checkListEntity);
                    _questionIndex++;
                    setState(() {

                    });
                  },
                  child: Card(child: Text(question.answers[index].answer),
                    color: question.answers[index].isChoosen == 1 ? Colors.lightGreen : Colors.white,),
                );
              }
          ),
        ),
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
