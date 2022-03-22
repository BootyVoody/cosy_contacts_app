import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_cubit.dart';
import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_state.dart';
import 'package:cosy_contacts/presentation/screens/detailed_contact/widgets/search_text_field.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedContact extends StatelessWidget {
  static const String route = '/detailed_contact';

  const DetailedContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as IntScreenArgument;

    return BlocProvider(
      create: (_) => DetailedContactCubit()..getDetailedContact(arg.value),
      child: BlocBuilder<DetailedContactCubit, DetailedContactState>(
        builder: (context, state) {
          final cubit = context.watch<DetailedContactCubit>();

          return Scaffold(
            appBar: AppBar(
              title: SearchTextField(
                onChanged: (query) {},
              ),
            ),
            body: buildBody(context, cubit),
          );
        },
      ),
    );
  }
}
