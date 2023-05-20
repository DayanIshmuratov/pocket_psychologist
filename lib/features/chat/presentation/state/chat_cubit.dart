import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/logger/logger.dart';
import '../../../../core/server/appwrite.dart';
import '../../../../core/server/database.dart';
import '../../domain/entity/message_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  StreamController<dynamic> _streamController = StreamController<dynamic>();
  Stream<dynamic> get resultStream => _streamController.stream;
  RealtimeSubscription? subscription;
  ChatCubit() : super(ChatInitial());


  void subscribe() {
    final realtime = Realtime(AppWriteProvider().client);
    subscription = realtime.subscribe(['databases.chat.collections.messages.documents']);
    subscription!.stream.listen((response) {
      final result = response.payload;
      final Message message = Message.fromJson(result);
      _streamController.add(message);
      logger.severe(result);
    });
  }

  void dispose() {
    subscription!.close();
  }

  Future<void> sendMessage(Message message) async {
    AppWriteDBProvider().db.createDocument(
              databaseId: 'chat',
              collectionId: 'messages',
              documentId: ID.unique(),
              data: {
                'message' : message.message,
                'user_id' : message.userId,
                'action' : message.action,
              },
            );
  }
}
