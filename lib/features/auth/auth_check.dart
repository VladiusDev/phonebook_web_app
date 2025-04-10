import 'package:flutter/material.dart';
import 'package:phone_book/features/auth/view/auth.dart';
import 'package:phone_book/features/phone_book/view/phone_book.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final session = supabase.auth.currentSession;

        if (session != null) {
          return PhoneBook();
        }

        return Auth();
      },
    );
  }
}
