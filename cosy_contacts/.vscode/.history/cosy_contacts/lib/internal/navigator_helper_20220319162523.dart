import 'package:cosy_contacts/presentation/screens/contacts/contacts_screen.dart';
import 'package:cosy_contacts/presentation/screens/home/home_screen.dart';
import 'package:cosy_contacts/presentation/screens/subgroups/subgroups_screen.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_argument.dart';
import 'package:flutter/material.dart';

class NavigatorHelper {
  void navigateToHome({required BuildContext context}) =>
      Navigator.pushNamed(context, HomeScreen.route);

  void navigateToSubgroups({
    required BuildContext context,
    required int groupId,
  }) =>
      Navigator.pushNamed(
        context,
        SubgroupsScreen.route,
        arguments: IntScreenArgument(groupId),
      );

  void navigateToContents({
    required BuildContext context,
    required int subgroupId,
  }) =>
      Navigator.pushNamed(
        context,
        ContactsScreen.route,
        arguments: IntScreenArgument(subgroupId),
      );
}
