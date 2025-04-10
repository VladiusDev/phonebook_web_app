import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:phone_book/phone_book_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaml/yaml.dart';

void main() async {
  final config = await loadYamlConfig();
  debugPrint(config['employee_api']['baseUrl']);

  await Supabase.initialize(
    url: config['supabase']['url'],
    anonKey: config['supabase']['anonKey'],
  );

  GetIt.I.registerLazySingleton<Dio>(() => Dio(BaseOptions(
          baseUrl:
              '${config['employee_api']['baseUrl']}:${config['employee_api']['port']}',
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
          })));

  runApp(const PhoneBookApp());
}

Future<YamlMap> loadYamlConfig() async {
  WidgetsFlutterBinding.ensureInitialized();

  final yamlString = await rootBundle.loadString('config.yaml');
  return loadYaml(yamlString) as YamlMap;
}

final supabase = Supabase.instance.client;
