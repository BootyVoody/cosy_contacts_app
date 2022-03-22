import 'package:cosy_contacts/domain/state/home/home_cubit.dart';
import 'package:cosy_contacts/domain/state/home/home_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
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
            body: _buildBody(state.loadingStatus),
          ),
        ),
      );

  Widget _buildBody(LoadingStatus status) {
    switch (status) {
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.done:

      default:
        return Container();
    }
  }
}
