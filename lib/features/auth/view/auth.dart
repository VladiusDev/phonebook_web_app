import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_book/features/auth/bloc/auth_bloc.dart';
import 'package:phone_book/strings.dart';
import 'package:phone_book/themes/theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthStatePage();
}

class _AuthStatePage extends State<AuthPage> {
  final login = TextEditingController();
  final pass = TextEditingController();
  late AuthorizationBloc _authBlock;

  @override
  void initState() {
    _authBlock = AuthorizationBloc();

    super.initState();
  }

  @override
  void dispose() {
    _authBlock.close();

    super.dispose();
  }

  Future<void> _signIn() async {
    _authBlock.add(PerfomAuth(login, pass));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBlock,
      child: BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {
          if (state is AuthorizationOK) {
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state is AuthorizationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
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
                    style: GoogleFonts.robotoSerif(
                        color: Colors.black, fontSize: 16),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15)),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onSubmitted: (_) => _signIn(),
                      autofillHints: const [AutofillHints.email],
                      controller: login,
                      decoration: InputDecoration(
                          filled: true,
                          label: Text(userTextField,
                              style: mainTheme.textTheme.headlineSmall),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.person, color: Colors.black54),
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onSubmitted: (_) => _signIn(),
                      autofillHints: const [AutofillHints.password],
                      controller: pass,
                      decoration: InputDecoration(
                          filled: true,
                          label: Text(passwordTextField,
                              style: mainTheme.textTheme.headlineSmall),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                      child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
                          builder: (context, state) {
                        if (state is AuthorizationProgress) {
                          return CircularProgressIndicator(
                            color: Colors.amber,
                          );
                        } else {
                          return Text(enterButtonText,
                              style: GoogleFonts.robotoSerif(
                                  color: Colors.white, fontSize: 16));
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
