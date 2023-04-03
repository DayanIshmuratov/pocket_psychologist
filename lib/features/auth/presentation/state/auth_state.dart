part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInSigned extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthSigned extends AuthState {
  final Account account;

  AuthSigned(this.account);

  @override
  List<Object?> get props => [];
}
