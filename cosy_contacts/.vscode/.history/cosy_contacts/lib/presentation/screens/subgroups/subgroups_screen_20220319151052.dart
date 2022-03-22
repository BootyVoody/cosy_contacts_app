import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/state/subgroups/subgroups_cubit.dart';
import 'package:cosy_contacts/domain/state/subgroups/subgroups_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/int_screen_arguments.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:cosy_contacts/presentation/widgets/error_card.dart';
import 'package:cosy_contacts/presentation/widgets/group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SubgroupsScreen extends StatelessWidget {
  static const String route = '/subgroups';

  final navigator = GetIt.I<NavigatorHelper>();

  SubgroupsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as IntScreenArguments;

    return BlocProvider(
      create: (_) => SubgroupsCubit()..getSubgroups(args.value),
      child: BlocBuilder<SubgroupsCubit, SubgroupsState>(
        builder: (context, state) {
          final cubit = context.watch<SubgroupsCubit>();

          return Scaffold(
            appBar: AppBar(),
            body: buildBody(context, cubit),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, SubgroupsCubit cubit) {
    switch (cubit.state.loadingStatus) {
      case LoadingStatus.loading:
        Future.delayed(
          Duration.zero,
          () => ProgressDialog.show(
            context: context,
            message: 'Загружаю подгруппы\nПожалуйста, подожди',
          ),
        );
        return const SizedBox.shrink();

      case LoadingStatus.done:
        ProgressDialog.dismiss();
        return buildSubgroupCards(context, cubit.state.groups);

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return ErrorCard(
          message: cubit.state.errorMessage,
          callback: () {},
        );

      case LoadingStatus.never:
        return const SizedBox.shrink();
    }
  }

  Widget buildSubgroupCards(BuildContext context, List<GroupModel> subgroups) =>
      GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        children: subgroups
            .map((subgroup) => GroupCard(
                  group: subgroup,
                  onTap: () {},
                ))
            .toList(),
      );
}
