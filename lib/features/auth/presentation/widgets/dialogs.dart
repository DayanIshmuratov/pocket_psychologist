import 'package:flutter/material.dart';

import '../../../../common/components/text.dart';
class DataTransferConfirmDialog extends StatelessWidget {
  final Function loadToDB;
  final Function loadToServer;
  const DataTransferConfirmDialog({required this.loadToServer, required this.loadToDB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showDataDialog(context);
  }

  showDataDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: AppText(value: 'Локальное и серверное хранилище содержат отличающиеся данные. Во избежание проблем выберите одну из хранилищ, откуда будут получены данные и в дальнейшем использованы.'),
        children: [
          Row(children: [
            ElevatedButton(onPressed: () {
              loadToDB;
            }, child: AppText(value: "Удаленный сервер")),
            ElevatedButton(onPressed: () {
              loadToServer;
            }, child: AppText(value: "Локальное хранилище")),
          ],)
        ],
      );
    }
    );
  }
}