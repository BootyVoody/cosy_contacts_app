import 'package:cosy_contacts/internal/style/theme.dart';
import 'package:cosy_contacts/presentation/screens/home/home_screen.dart';
import 'package:cosy_contacts/presentation/screens/not_found/not_found_screen.dart';
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
      onGenerateRoute: (settings) =>
          CupertinoPageRoute(builder: (_) => determineScreen(settings)),
    );
  }

  Widget determineScreen(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return HomeScreen();
      case SubgroupsScreen.route:
        return SubgroupsScreen();
      default:
        return const NotFoundScreen();
    }
  }
}
