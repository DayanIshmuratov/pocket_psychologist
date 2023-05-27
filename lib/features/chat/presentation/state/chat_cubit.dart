import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/server/appwrite.dart';
import '../../../../core/server/database.dart';
import '../../domain/entity/message_entity.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as appwriteConsts;

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  StreamController<Message> _streamController = StreamController<Message>.broadcast();
  Stream<Message> get resultStream => _streamController.stream.asBroadcastStream();
  //  StreamController<dynamic> _streamController = StreamController<dynamic>.broadcast();
  //   Stream<dynamic> get resultStream => _streamController.stream.asBroadcastStream();
  RealtimeSubscription? subscription;
  ChatCubit() : super(ChatLoading());

  Future<void> subscribe() async {
    if (await InternetConnectionChecker().hasConnection) {
      final realtime = Realtime(AppWriteProvider().client);
      subscription = realtime.subscribe(['databases.chat.collections.messages.documents']);
      subscription!.stream.listen((response) {
        final result = response.payload;
        logger.severe(result);
        final message = Message.fromJson(result);
        _streamController.add(message);
      });
      final lastMessages = await getLastMessages();
      emit(ChatLoaded(lastMessages.reversed.toList()));
    } else {
      emit(ChatError("Нет соединения."));
    }
  }

  void dispose() {
    logger.severe('ЗАКРЫТИЕ ПОДПИСОК');
    subscription!.close();
    emit(ChatLoading());
  }

  Future<void> sendMessage(Message message) async {
    if (await InternetConnectionChecker().hasConnection) {
      AppWriteDBProvider().db.createDocument(
        databaseId: appwriteConsts.appwriteChatDatabaseId,
        collectionId: appwriteConsts.appwriteMessageCollectionId,
        documentId: ID.unique(),
        data: {
          'message' : message.message,
          'user_id' : message.userId,
          'action' : message.action,
          'sender_name' : message.senderName,
        },
      );
    } else {
      throw NetworkException();
    }

  }

  Future<List<Message>> getLastMessages() async {
    final documentList = await AppWriteDBProvider().db.
    listDocuments(
      databaseId: appwriteConsts.appwriteChatDatabaseId,
      collectionId: appwriteConsts.appwriteMessageCollectionId,
      queries: [
        Query.orderDesc(""),
        Query.limit(50)
      ],
    );
    return documentList.documents.map((e) => Message.fromJson(e.data)).toList();
  }
}
