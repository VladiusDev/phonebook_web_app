part of 'phone_list_bloc.dart';

abstract class PhoneListState {}

class PhoneListInitial extends PhoneListState {}

class PhoneListLoaded extends PhoneListState {
  final List<Employee> phoneList;

  PhoneListLoaded(this.phoneList);
}

class PhoneListLoading extends PhoneListState {}

class PhoneListLoadingError extends PhoneListState {
  final String error;

  PhoneListLoadingError({required this.error});
}
