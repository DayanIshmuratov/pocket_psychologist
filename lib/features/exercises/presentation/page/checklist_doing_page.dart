import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/checklist_state/checklist_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_bloc.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_event.dart';
import 'package:pocket_psychologist/features/exercises/presentation/state/question_state/question_state.dart';

class CheckListDoingPage extends StatefulWidget {
  final QuestionEntity questions;

  const CheckListDoingPage({super.key, required this.questions});

  @override
  State<CheckListDoingPage> createState() => _CheckListDoingPageState();
}

class _CheckListDoingPageState extends State<CheckListDoingPage> {
  int _questionIndex = 0;
  void initState() {
    super.initState();
    _questionIndex = widget.questions.answer.indexOf(0);
  }


  Widget build(BuildContext context) {
    // final _bloc = context.read<QuestionBloc>();
    // _bloc.add(OnQuestionEvent(nameId: widget.checkListEntity.id));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.pop(context, widget.questions);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Упражнения"),
        centerTitle: true,
      ),
      body: (_questionIndex < widget.questions.id.length) && _questionIndex != -1
                ? doingWidget()
                : doneWidget()
  );
  }

  Widget doingWidget() {
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
            widget.questions.question[_questionIndex],
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                widget.questions.answer[_questionIndex] = 1;
                _questionIndex++;
              });
            },
            child: Card(child: Text('Верно'), color: widget.questions.answer[_questionIndex] == 1 ? Colors.lightGreen : Colors.white,)),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                widget.questions.answer[_questionIndex] = 2;
                _questionIndex++;
                //result[_questionIndex].add(1)
              });
            },
            child: Card(child: Text('Неверно'), color: widget.questions.answer[_questionIndex] == 2 ? Colors.lightGreen : Colors.white  ,)),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                widget.questions.answer[_questionIndex] = 3;
                _questionIndex++;
                //result[_questionIndex].add(1)
              });
            },
            child: Card(child: Text('Не знаю'), color: widget.questions.answer[_questionIndex] == 3 ? Colors.lightGreen : Colors.white  ,)),
      ],
    );
  }

  Widget doneWidget() {
    return Column(
      children: [
        Text('Вы завершили чек лист'),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, widget.questions);
              // Идет сохранение результата в БД
            },
            child: Text('Посмотреть результаты')),
      ],
    );
  }
}
