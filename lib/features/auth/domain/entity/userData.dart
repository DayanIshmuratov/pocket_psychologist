import 'dart:convert';
import 'package:appwrite/models.dart';
import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  //
  final String id;
  final String name;
  final String? registration;
  final bool? status;
  final String? passwordUpdate;
  final String email;
  final bool? emailVerification;
  final Map<String, dynamic>? prefs;
  //
  const UserData({
    required this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
      'status': status,
      'passwordUpdate': passwordUpdate,
      'email': email,
      'emailVerification': emailVerification,
      'prefs': prefs,
    };
  }

  factory UserData.fromMap(Account user) {
    return UserData(
      id: user.$id,
      name: user.name,
      registration: user.registration,
      status: user.status,
      passwordUpdate: user.passwordUpdate,
      email: user.email,
      emailVerification: user.emailVerification,
      prefs: user.prefs.data,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, registration: $registration, status: $status, passwordUpdate: $passwordUpdate, email: $email, emailVerification: $emailVerification, prefs: $prefs)';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    registration,
    status,
    passwordUpdate,
    email,
    emailVerification,
    prefs
  ];
}