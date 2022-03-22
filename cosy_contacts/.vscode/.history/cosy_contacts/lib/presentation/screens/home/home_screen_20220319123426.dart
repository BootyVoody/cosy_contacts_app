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
          () => ProgressDialog.show(
            context: context,
            message: 'Пожалуйста, подожди',
          ),
        );
        return const SizedBox.shrink();

      case LoadingStatus.done:
        ProgressDialog.dismiss();
        return buildGroupCards(state.groups);

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return buildErrorCard(
          message: state.errorMessage,
          callback: () {},
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget buildGroupCards(List<GroupModel> groups) => GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        children: groups
            .map((group) => Card(
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/partners.png', height: 120.0),
                      Text(
                        group.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ))
            .toList(),
      );

  Widget buildErrorCard({
    required String message,
    required VoidCallback callback,
  }) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  color: const Color(0xffffda4d),
                  child: Column(
                    children: const [
                      Icon(Icons.warning, size: 48),
                      Text(
                        'Упс..',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: callback,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.refresh),
                            SizedBox(width: 8.0),
                            Text('Попробовать снова'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
