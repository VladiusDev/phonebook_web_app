part of 'auth_bloc.dart';

abstract class AuthorizationState {}

class AuthorizationInitial extends AuthorizationState {}

class AuthorizationError extends AuthorizationState {
  final String error;

  AuthorizationError({required this.error});
}

class AuthorizationProgress extends AuthorizationState {}

class AuthorizationOK extends AuthorizationState {}
