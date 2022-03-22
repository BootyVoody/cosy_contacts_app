import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final _dio = D
  final _backendApi = BackendApi(_dio)
  GetIt.I.registerSingleton()

  runApp(const MyApp());
}
