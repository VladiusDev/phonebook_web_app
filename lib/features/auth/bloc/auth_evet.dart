part of 'auth_bloc.dart';

abstract class AuthorizationEvent {}

class PerfomAuth extends AuthorizationEvent {
  final TextEditingController login;
  final TextEditingController pass;

  PerfomAuth(this.login, this.pass);
}
