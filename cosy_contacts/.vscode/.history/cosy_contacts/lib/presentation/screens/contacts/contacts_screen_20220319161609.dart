import 'package:cosy_contacts/domain/state/contacts/contacts_cubit.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_state.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsScreen extends StatelessWidget {
  static const String route = '/contacts';

  final navigator = GetIt.I<NavigatorHelper>();

  ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as IntScreenArgument;

    return BlocProvider(
      create: (_) => ContactsCubit()..getShortenedContacts(arg.value),
      child: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
