import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  final String userId;
  final DateTime? date;
  final String action;

  Message({required this.message, required this.userId, required this.date, required this.action});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json['message'],
        userId: json['user_id'],
        date: json['permissions']['createdAt'],
        action: json['action']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [message, userId, date, action];


}