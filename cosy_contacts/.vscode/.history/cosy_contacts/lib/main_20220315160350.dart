import 'package:cosy_contacts/domain/repository/group_repository.dart';
import 'package:cosy_contacts/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  final _groupRepository = GroupRepository();
  GetIt.I.registerSingleton()

  runApp(const MyApp());
}
