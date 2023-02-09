import 'package:flutter/material.dart';
import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entity.dart';

class CheckListCard extends StatelessWidget {
  final CheckListEntity entity;

  const CheckListCard({super.key, required this.entity});
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: entity.result != null ? IconButton(icon: Icon(Icons.done, color: Colors.green),
          onPressed: (){},
          tooltip: "Вы уже прошли данный чек лист",
        ) : IconButton(icon: Icon(Icons.cancel, color: Colors.red),
          onPressed: (){},
          tooltip: "Вы еще не прошли данный чек лист",
        ) ,
        title: Text(entity.name),
        subtitle: Text(entity.description),
      )
      );
  }
}