import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:phone_book/model/employee.dart';
import 'package:phone_book/strings.dart';

class ApiService {
  final Dio _dio = GetIt.I<Dio>();

  Future<List<Employee>> fetchEmployees([String? query]) async {
    try {
      String endpoint = '/employees';

      if (query != null && query.isNotEmpty) {
        endpoint = '/employees?query=$query';
      }

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((json) => Employee.fromJson(json)).toList();
      } else {
        throw Exception('$apiError ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
