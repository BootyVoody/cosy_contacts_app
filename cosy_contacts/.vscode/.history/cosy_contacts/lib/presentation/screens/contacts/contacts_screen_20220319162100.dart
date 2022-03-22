import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_cubit.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_argument.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:cosy_contacts/presentation/widgets/error_card.dart';
import 'package:cosy_contacts/presentation/widgets/shortened_contact_card.dart';
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
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          final cubit = context.watch<ContactsCubit>();

          return Scaffold(
            appBar: AppBar(),
            body: buildBody(context, cubit, arg.value),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, ContactsCubit cubit, int subgroupId) {
    switch (cubit.state.loadingStatus) {
      case LoadingStatus.loading:
        Future.delayed(
          Duration.zero,
          () => ProgressDialog.show(
            context: context,
            message: 'Загружаю контакты\nПожалуйста, подожди',
          ),
        );
        return const SizedBox.shrink();

      case LoadingStatus.done:
        ProgressDialog.dismiss();
        return buildContactCards(context, cubit.state.contacts);

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return ErrorCard(
          message: cubit.state.errorMessage,
          callback: () => cubit.getShortenedContacts(subgroupId),
        );

      case LoadingStatus.never:
        return const SizedBox.shrink();
    }
  }

  Widget buildContactCards(
    BuildContext context,
    List<ShortenedContactModel> contacts,
  ) =>
      ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        children: contacts
            .map((e) => ShortenedContactCard(
                  contact: e,
                  callback: () {},
                ))
            .toList(),
      );
}
