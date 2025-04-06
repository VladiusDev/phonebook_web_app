part of 'phone_list_bloc.dart';

abstract class PhoneListEvent {}

class LoadPhoneBook extends PhoneListEvent {
  final String? query;

  LoadPhoneBook([this.query]);
}
