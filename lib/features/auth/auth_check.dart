import 'package:flutter/material.dart';
import 'package:phone_book/features/auth/view/auth.dart';
import 'package:phone_book/features/phone_book/view/phone_book.dart';
import 'package:phone_book/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();

    _checkSessionValidity();
  }

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

        return AuthPage();
      },
    );
  }

  Future<void> _checkSessionValidity() async {
    try {
      final response = await supabase.auth.getUser();
      if (response.user == null) {
        await supabase.auth.signOut();
      }
    } catch (e) {
      await supabase.auth.signOut();
    }
  }
}
