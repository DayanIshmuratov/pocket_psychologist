part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<Message> lastMessages;

  ChatLoaded(this.lastMessages);
  @override
  List<Object> get props => [];
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
  @override
  List<Object> get props => [];
}
