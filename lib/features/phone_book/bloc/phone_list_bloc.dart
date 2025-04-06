import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/features/api/api_service.dart';
import 'package:phone_book/model/employee.dart';

part 'phone_list_event.dart';
part 'phone_list_state.dart';

class PhoneListBloc extends Bloc<PhoneListEvent, PhoneListState> {
  PhoneListBloc() : super(PhoneListInitial()) {
    on<LoadPhoneBook>((event, emit) async {
      emit(PhoneListLoading());
      List<Employee> phoneList = [];

      try {
        if (event.query != null && event.query!.isNotEmpty) {
          String query = event.query!;

          phoneList = await ApiService().fetchEmployees(query);
        } else {
          phoneList = await ApiService().fetchEmployees();
        }

        emit(PhoneListLoaded(phoneList));
      } catch (e) {
        emit(PhoneListLoadingError(error: e.toString()));
      }
    });
  }
}
