import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/presentation/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  final _dio = Dio();
  _dio.options = BaseOptions(
    contentType: 'application/json',
    connectTimeout: 7000,
    receiveTimeout: 7000,
    sendTimeout: 7000,
  );

  final _backendApi = BackendApi(_dio);
  GetIt.I.registerSingleton(_backendApi);

  runApp(const MyApp());
}
