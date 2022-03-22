import 'package:cosy_contacts/internal/style/theme.dart';
import 'package:cosy_contacts/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosy Contacts',
      theme: AppTheme.materialTheme,
      initialRoute: HomeScreen.homeScreenRoute,
      routes: {
        HomeScreen.homeScreenRoute: (context) => HomeScreen(),
      },
    );
  }
}
