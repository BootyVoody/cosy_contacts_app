import 'package:cosy_contacts/app.dart';
import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/data/repository/group_repository_impl.dart';
import 'package:cosy_contacts/domain/repository/group_repository.dart';
import 'package:cosy_contacts/internal/constants/urls.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  final _dio = Dio();
  _dio.options = BaseOptions(
    baseUrl: URLs.baseUrl,
    contentType: 'application/json',
    connectTimeout: 7000,
    receiveTimeout: 7000,
    sendTimeout: 7000,
  );

  final _navigatorHelper = NavigatorHelper();
  GetIt.I.registerSingleton(_navigatorHelper);

  final _backendApi = BackendApi(_dio);
  GetIt.I.registerSingleton(_backendApi);

  final GroupRepository _groupRepository = GroupRepositoryImpl();
  GetIt.I.registerSingleton(_groupRepository);

  final GroupRepository _contactsRepository = GroupRepositoryImpl();
  GetIt.I.registerSingleton(_contactsRepository);

  runApp(const App());
}
