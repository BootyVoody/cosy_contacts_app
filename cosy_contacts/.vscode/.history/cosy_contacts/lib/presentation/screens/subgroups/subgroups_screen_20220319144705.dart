import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubgroupsScreen extends StatelessWidget {
  static const String route = '/subgroups';

  final navigator = GetIt.I<NavigatorHelper>();
  final int groupId;

  SubgroupsScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('subgroups (group #$groupId)')),
      );
}
