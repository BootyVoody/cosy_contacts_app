import 'package:cosy_contacts/domain/state/subgroups/subgroups_cubit.dart';
import 'package:cosy_contacts/domain/state/subgroups/subgroups_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:cosy_contacts/presentation/widgets/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SubgroupsCubit()..getSubgroups(groupId),
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
        return SizedBox();

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return ErrorCard(
          message: cubit.state.errorMessage,
          callback: () {},
        );
    }
  }
}
