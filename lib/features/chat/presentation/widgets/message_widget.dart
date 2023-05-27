import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/core/server/appwrite.dart';

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
    switch (message.action) {
      case 'message':
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: userData.id == message.userId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              AppText(
                value: message.message,
                color: Colors.black,
              ),
              // subtitle: Text(messages[i].date!.toIso8601String()),
            ],
          ),
        );
      case 'in' :
        return Center(child: AppText(value: '${Account(AppWriteProvider.instance.client.)} вошел(ла) в чат.', color: Colors.green,));
      case 'out' :
        return Center(child: AppText(value: '${userData.name} вышел(ла) из чата.', color: Colors.red,));
      default: return const SizedBox();
    }
  }
}

