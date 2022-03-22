import 'package:cosy_contacts/domain/model/contact_model.dart';
import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_cubit.dart';
import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/presentation/screens/detailed_contact/widgets/search_text_field.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_argument.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:cosy_contacts/presentation/widgets/error_card.dart';
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

  Widget buildBody(
    BuildContext context,
    DetailedContactCubit cubit,
    int contactId,
  ) {
    switch (cubit.state.loadingStatus) {
      case LoadingStatus.loading:
        Future.delayed(
          Duration.zero,
          () => ProgressDialog.show(
            context: context,
            message: 'Загружаю данные\nПожалуйста, подожди',
          ),
        );
        return const SizedBox.shrink();

      case LoadingStatus.done:
        ProgressDialog.dismiss();
        return buildDetails(context, cubit.state.contact!);

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return ErrorCard(
          message: cubit.state.errorMessage,
          callback: () => cubit.getDetailedContact(contactId),
        );
    }
  }

  Widget buildDetails(BuildContext context, ContactModel contact) {}
}
