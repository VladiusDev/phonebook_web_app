import 'package:phone_book/features/auth/auth_check.dart';
import 'package:phone_book/features/auth/view/auth.dart';
import 'package:phone_book/features/phone_book/view/phone_book.dart';

final routes = {
  '/': (context) => AuthCheck(),
  '/main': (context) => PhoneBook(),
  '/auth': (context) => Auth()
};
