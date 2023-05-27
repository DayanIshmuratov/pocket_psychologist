import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import 'package:pocket_psychologist/features/chat/presentation/state/chat_cubit.dart';

import '../../../../common/components/text.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';
import '../../../auth/domain/entity/userData.dart';
import '../../domain/entity/message_entity.dart';
import 'message_widget.dart';

class ChatWidgets extends StatefulWidget {
  final UserData userData;
  final ChatCubit chatCubit;

  const ChatWidgets({super.key, required this.userData, required this.chatCubit});

  @override
  State<ChatWidgets> createState() {
    return _ChatWidgetsState();
  }
}

class _ChatWidgetsState extends State<ChatWidgets> {
  StreamSubscription<Message>? subscription;
  List<Message> messages = [];

  @override
  void initState()  {
    super.initState();
    subscription = widget.chatCubit.resultStream.listen((message) {
      logger.info("ПОЙМАНО $message");
      messages.add(message);
      setState(() {
        logger.info("ВЫЗВАНО SETSTTATE");
      });
    });
    joinToChat();
  }
  // StreamSubscription<Message> subscription = stream.listen((event) {
  //
  // });

  void joinToChat() {
    widget.chatCubit.sendMessage(
      Message(
          message: '', userId: widget.userData.id, date: null, action: 'in'),
    );
    widget.chatCubit.subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    subscription!.cancel();
    subscription = null;
    widget.chatCubit.dispose();
    widget.chatCubit.sendMessage(
      Message(message: '', userId: widget.userData.id, date: null, action: 'out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChatLoaded) {
          messages = state.lastMessages;
          return Column(
            children: [
          Expanded(
          child: ListView.builder(
          itemCount: messages.length,
              itemBuilder: (context, i) {
                return MessageWidget(message: messages[i], userData: widget.userData,);
              }),
        ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        try {
                         await widget.chatCubit.sendMessage(Message(
                              message: messageController.text,
                              userId: widget.userData.id,
                              date: null,
                              action: 'message'));
                        } on NetworkException catch (e) {
                          SnackBars.showSnackBar(context, e.message, Colors.red);
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ChatError) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTitle(value: 'Нет соединения'),
              ElevatedButton(onPressed: () {
                setState(() {});
              }, child: AppSubtitle(value: 'Обновить',))
            ],
          ));
        }
        return const Center(child: AppTitle(value: 'Неожиданная ошибка'));
      },
    );
  }
}
