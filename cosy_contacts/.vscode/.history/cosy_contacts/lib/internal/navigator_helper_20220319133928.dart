import 'package:cosy_contacts/presentation/screens/home/home_screen.dart';
import 'package:cosy_contacts/presentation/screens/subgroups/subgroups_screen.dart';
import 'package:flutter/material.dart';

class NavigatorHelper {
  void navigateToHome({required BuildContext context}) =>
      Navigator.pushNamed(context, HomeScreen.route);

  void navigateToSubgroups({required BuildContext context}) =>
      Navigator.pushNamed(context, SubgroupsScreen.route);
}
