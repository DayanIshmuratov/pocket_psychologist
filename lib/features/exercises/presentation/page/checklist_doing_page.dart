import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
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
    questionBloc.add(LoadListEvent(id: widget.checkListEntity.id));
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          // leading: IconButton(onPressed: () {
          //   Navigator.pop(context);
          // }, icon: Icon(Icons.arrow_back)),
          title: AppSubtitle(value: widget.checkListEntity.name),
          centerTitle: true,
        ),
        body: (_questionIndex < widget.checkListEntity.count) &&
                _questionIndex != -1
            ? BlocBuilder<QuestionBloc, BaseState>(builder: (context, state) {
                if (state is LoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LoadedListState<QuestionEntity>) {
                  return doingWidget(
                      state.entities, questionBloc, answerBloc);
                } else if (state is ErrorState) {
                  return Center(
                    child: Text(state.text),
                  );
                } else {
                  return Center(child: Text("Неожиданная ошибка"));
                }
              })
            : doneWidget(checklistBloc));
  }

  Widget doingWidget(List<QuestionEntity> questions, QuestionBloc questionBloc, AnswerBloc answerBloc) {
    answerBloc.add(LoadListEvent(id: questions[_questionIndex].id));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          _questionIndex == 0
              ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            onPressed: () {},
            child: Text("Предыдущий вопрос"),
          )
              : ElevatedButton(
            onPressed: () {
              setState(() {
                _questionIndex--;
              });
            },
            child: Text("Предыдущий вопрос"),
          ),
            AppSubtitle(value: "${_questionIndex + 1} / ${widget.checkListEntity.count}")
        ],),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppSubtitle(value:
                questions[_questionIndex].question ?? '',
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          BlocBuilder<AnswerBloc, BaseState>(builder: (context, state) {
            if (state is LoadedListState<AnswerEntity>) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.entities.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()  {
                          questions[_questionIndex].answerId =
                              state.entities[index].id;
                          questionBloc.add(
                              UpdateEvent(entity: questions[_questionIndex]));
                          _questionIndex++;
                          setState(() {});
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(value: state.entities[index].answer),
                          ),
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
        ],
      ),
    );
  }

  Widget doneWidget(CheckListBloc checkListBloc) {
    checkListBloc.add(LoadListEvent());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSubtitle(value: 'Вы успешно завершили опрос "${widget.checkListEntity.name}"', textAlign: TextAlign.center),
          BlocBuilder<CheckListBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadedListState) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'result_page', arguments: state.entities[widget.checkListEntity.id - 1]);
                    },
                    child: AppSubtitle(value: 'Посмотреть результат',));
              }
              else return Center(child: CircularProgressIndicator());
              },
          ),
        ],
      ),
    );
  }
}
