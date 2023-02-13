import 'package:flutter/material.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/checklist_entity.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/question_entity.dart';

class CheckListCard extends StatefulWidget {
  final CheckListEntity entity;

  CheckListCard({super.key, required this.entity});

  State<CheckListCard> createState() {
    return _CheckListCardState();
  }
}

class _CheckListCardState extends State<CheckListCard> {
  // final entity = widget.entity;
  bool _isClosed = true;

  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return _isClosed
        ? GestureDetector(
            onTap: () {
              setState(() {
                _isClosed = !_isClosed;
              });
            },
            child: Card(
              child: _closedWidget(),
            ))
        : GestureDetector(
            onTap: () {
              setState(() {
                _isClosed = !_isClosed;
              });
            },
            child: Card(child: _openedWidget()),
          );
  }

  Widget _openedWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            // trailing: widget.entity.result != null
            //     ? IconButton(
            //         icon: Icon(Icons.done, color: Colors.green),
            //         onPressed: () {},
            //         tooltip: "Вы уже прошли данный чек лист",
            //       )
            //     : IconButton(
            //         icon: Icon(Icons.cancel, color: Colors.red),
            //         onPressed: () {},
            //         tooltip: "Вы еще не прошли данный чек лист",
            //       ),
            title: Text(widget.entity.name),
            subtitle: Text(widget.entity.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.entity.questions.answer.indexOf(0) == -1 ? widget.entity.questions.answer.length : widget.entity.questions.answer.indexOf(0)}/${widget.entity.questions.answer.length}'),
              ElevatedButton(
                onPressed: () async {
                  widget.entity.questions = await Navigator.pushNamed(context, 'checklist_doing_page', arguments: widget.entity.questions) as QuestionEntity;
                  setState(() {
                  });
                },
                child: Text('Выполнить'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _closedWidget() {
    return ListTile(
      // trailing: widget.entity.result != null
      //     ? IconButton(
      //         icon: Icon(Icons.done, color: Colors.green),
      //         onPressed: () {},
      //         tooltip: "Вы уже прошли данный чек лист",
      //       )
      //     : IconButton(
      //         icon: Icon(Icons.cancel, color: Colors.red),
      //         onPressed: () {},
      //         tooltip: "Вы еще не прошли данный чек лист",
      //       ),
      title: Text(widget.entity.name),
      subtitle: Text(widget.entity.description,
          style: TextStyle(overflow: TextOverflow.ellipsis)),
    );
  }
}
