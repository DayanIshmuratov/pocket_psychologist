import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';
import 'package:pocket_psychologist/core/server/user.dart';

import '../../../../common/components/text.dart';
import '../../../auth/domain/entity/userData.dart';
import '../../domain/entity/message_entity.dart';

class MessageWidget extends StatelessWidget {
  final bool isPreceding;
  final UserData userData;
  final Message message;

  MessageWidget(
      {super.key, required this.message, required this.userData, required this.isPreceding});
  @override
  Widget build(BuildContext context) {
    bool isMine = userData.id == message.userId;
    List<Widget> messageWidgets = [
      // SizedBox(width: 40, child:
      //   Image.asset('assets/images/no_image.jpg'),),
      Expanded(
        child: Align(
          alignment: isMine ? Alignment.topRight : Alignment.topLeft,
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column (
                  crossAxisAlignment: isMine ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
                   children: [
                     Text(message.senderName),
                     Text(message.message,
                       style:  TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                     ),
                       textAlign: TextAlign.justify,),
                     Text(message.date?.substring(11, 16) ?? 'Нет даты',
                     style: const TextStyle(fontSize: 12)),
                   ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 40,)
    ];
    switch (message.action) {
      case 'message':
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (isMine)
              for (int i = messageWidgets.length - 1; i >= 0; i--)
                messageWidgets[i]
              else
              for (int i = 0; i < messageWidgets.length; i++)
                messageWidgets[i]
              // subtitle: Text(messages[i].date!.toIso8601String()),
            ],
          ),
        );
      case 'in' :
        return Center(child: AppText(value: '${message.senderName} вошел(ла) в чат.', color: Colors.green,));
      case 'out' :
        return Center(child: AppText(value: '${message.senderName} вышел(ла) из чата.', color: Colors.red,));
      default: return const SizedBox();
    }
  }

}

