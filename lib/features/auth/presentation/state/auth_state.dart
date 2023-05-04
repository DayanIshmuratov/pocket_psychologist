part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthSigned extends AuthState {
  final UserData userData;

  AuthSigned({required this.userData});
  @override
  List<Object> get props => [];
}

class AuthUnSigned extends AuthState {

  AuthUnSigned();

  @override
  List<Object?> get props => [];
}
