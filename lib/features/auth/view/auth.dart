import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_book/main.dart';
import 'package:phone_book/strings.dart';
import 'package:phone_book/themes/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final login = TextEditingController();
  final pass = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    try {
      setState(() => _isLoading = true);
      await supabase.auth.signInWithPassword(
        email: login.text.trim(),
        password: pass.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/darvin.png',
                width: 100,
                height: 100,
              ),
              Padding(padding: EdgeInsets.only(bottom: 5)),
              Text(
                appTitle,
                style:
                    GoogleFonts.robotoSerif(color: Colors.black, fontSize: 16),
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: login,
                  decoration: InputDecoration(
                      filled: true,
                      label: Text(userTextField,
                          style: mainTheme.textTheme.headlineSmall),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(Icons.person, color: Colors.black54),
                      fillColor: Colors.white),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: pass,
                  decoration: InputDecoration(
                      filled: true,
                      label: Text(passwordTextField,
                          style: mainTheme.textTheme.headlineSmall),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black54,
                      ),
                      fillColor: Colors.white),
                  obscureText: true,
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _signIn(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 35, 106, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(enterButtonText,
                          style: GoogleFonts.robotoSerif(
                              color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
