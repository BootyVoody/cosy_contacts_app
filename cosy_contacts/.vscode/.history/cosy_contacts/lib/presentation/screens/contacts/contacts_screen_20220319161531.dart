import 'package:cosy_contacts/domain/state/contacts/contacts_cubit.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsScreen extends StatelessWidget {
  static const String route = '/contacts';

  final navigator = GetIt.I<NavigatorHelper>();

  ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsCubit()..getShortenedContacts(subgroupId),
    );
  }
}
