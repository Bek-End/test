part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthNotState extends AuthState {}
final class AuthInProgressState extends AuthState {}
final class AuthSuccessState extends AuthState {}
