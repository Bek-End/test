part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitEvent extends AuthEvent {}

class AuthRequestEvent extends AuthEvent {
  const AuthRequestEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [...super.props, username, password];
}
