import 'package:cosy_contacts/internal/style/theme.dart';
import 'package:cosy_contacts/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosy Contacts',
      theme: AppTheme.materialTheme,
      home: const HomeScreen(),
    );
  }
}
