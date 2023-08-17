import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String senderName;
  final List<Message>? reply;
  final String message;
  final String userId;
  final String? date;
  final String action;

  const Message({required this.message, required this.userId, this.date, required this.action, required this.senderName, this.reply});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        senderName: json['sender_name'],
        message: json['message'],
        userId: json['user_id'],
        date: json['\$createdAt'],
        action: json['action']);
  }

  @override
  List<Object?> get props => [message, userId, date, action];
}



