import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/state/home/home_cubit.dart';
import 'package:cosy_contacts/domain/state/home/home_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  static const String homeScreenRoute = '/home';

  final _navigator = GetIt.I<NavigatorHelper>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) {
          final cubit = HomeCubit()..getGroups();
          return cubit;
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: _buildBody(context, state),
          ),
        ),
      );

  Widget _buildBody(BuildContext context, HomeState state) {
    switch (state.loadingStatus) {
      case LoadingStatus.loading:
        Future.delayed(
          Duration.zero,
          () => ProgressDialog.show(context, 'Пожалуйста, подожди'),
        );
        return const SizedBox.shrink();
      case LoadingStatus.done:
        ProgressDialog.dismiss();
        return _buildGroupCards(state.groups);
      case LoadingStatus.error:
        return Center(
          child: Text('Error: ${state.errorMessage}'),
        );
      default:
        return Container();
    }
  }

  Widget _buildGroupCards(List<GroupModel> groups) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        child: GridView.count(
          crossAxisCount: 2,
          children: groups
              .map((group) => Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/partners.png',
                          height: 120.0,
                        ),
                        Text(
                          group.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
}
