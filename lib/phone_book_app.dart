import 'package:flutter/material.dart';
import 'package:phone_book/routes.dart';
import 'package:phone_book/strings.dart';
import 'package:phone_book/themes/theme.dart';

class PhoneBookApp extends StatelessWidget {
  const PhoneBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: mainTheme,
      routes: routes,
    );
  }
}
