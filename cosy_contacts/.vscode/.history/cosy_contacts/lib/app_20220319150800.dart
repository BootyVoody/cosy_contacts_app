import 'package:cosy_contacts/internal/style/theme.dart';
import 'package:cosy_contacts/presentation/screens/home/home_screen.dart';
import 'package:cosy_contacts/presentation/screens/subgroups/subgroups_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosy Contacts',
      theme: AppTheme.materialTheme,
      initialRoute: HomeScreen.route,
      onGenerateRoute: onGenerateRoute,
      routes: {
        HomeScreen.route: (context) => HomeScreen(),
        SubgroupsScreen.route: (context) => SubgroupsScreen(),
      },
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case SubgroupsScreen.route:
        return CupertinoPageRoute(builder: (_) => SubgroupsScreen());
    }
  }
}