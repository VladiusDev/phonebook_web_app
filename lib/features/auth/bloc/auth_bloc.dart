import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_evet.dart';
part 'auth_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<PerfomAuth>((event, emit) async {
      emit(AuthorizationProgress());

      try {
        await supabase.auth.signInWithPassword(
          email: event.login.text.trim(),
          password: event.pass.text.trim(),
        );

        emit(AuthorizationOK());
      } on AuthException catch (e) {
        emit(AuthorizationError(error: e.message));
      }
    });
  }
}
