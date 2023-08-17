import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/validators/validators.dart';
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

  ScrollController _scrollController = ScrollController();
  StreamSubscription<Message>? subscription;
  List<Message> messages = [];
  final _key = GlobalKey<FormState>();

  @override
  void initState()  {
    super.initState();
    subscription = widget.chatCubit.resultStream.listen((message) {
      logger.info("ПОЙМАНО $message");
      messages.add(message);
      scrollDown(100);

      setState(() {
        logger.info("ВЫЗВАНО SETSTTATE");
      });
    });
    joinToChat();
    widget.chatCubit.stream.listen((state) {
      if (state is ChatLoaded) {
        scrollDown(0);
      }
    });

  }

  void scrollDown(int plus) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController.hasListeners) {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + plus,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 500));
      }
    });
  }

  void joinToChat() {
    widget.chatCubit.sendMessage(
      Message(
          message: '', userId: widget.userData.id, action: 'in', senderName: widget.userData.name),
    );
    widget.chatCubit.subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    subscription!.cancel();
    widget.chatCubit.dispose();
    widget.chatCubit.sendMessage(
      Message(message: '', userId: widget.userData.id, date: null, action: 'out',  senderName: widget.userData.name),
    );
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return Form(
      key: _key,
      child: BlocBuilder<ChatCubit, ChatState>(
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
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, i) {
                  bool isPreceding = false;
                  if (i > 0) {
                  isPreceding = (messages[i].userId == messages[i - 1].userId) && (messages[i].action == 'message' && messages[i - 1].action == 'message');
                  }
                  return Column(
                    children: [
                      MessageWidget(message: messages[i], userData: widget.userData, isPreceding: isPreceding,),
                      const SizedBox(height: 4,)
                    ],
                  );
                }),
          ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: messageController,
                    maxLength: 256,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            try {
                              await widget.chatCubit.sendMessage(Message(
                                  message: messageController.text,
                                  userId: widget.userData.id,
                                  action: 'message',
                                  senderName: widget.userData.name));
                            } on NetworkException catch (e) {
                              SnackBars.showSnackBar(context, e.message, Colors.red);
                            } on AppwriteException catch (e) {
                              SnackBars.showSnackBar(context, e.message ?? 'Неизвестная ошибка', Colors.red);
                            }
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    validator: (value) {
                      return Validators.validateMessage(text: value as String);
                    },
                  ),
                ),
              ],
            );
          }
          if (state is ChatError) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppTitle(value: 'Нет соединения'),
                ElevatedButton(onPressed: () {
                  setState(() {});
                }, child: const AppSubtitle(value: 'Обновить',))
              ],
            ));
          }
          return const Center(child: AppTitle(value: 'Неожиданная ошибка'));
        },
      ),
    );
  }
}
