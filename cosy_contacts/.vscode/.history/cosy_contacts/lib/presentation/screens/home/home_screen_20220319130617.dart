import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/state/home/home_cubit.dart';
import 'package:cosy_contacts/domain/state/home/home_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:cosy_contacts/internal/constants/transparent_image.dart';
import 'package:cosy_contacts/internal/navigator_helper.dart';
import 'package:cosy_contacts/presentation/utils/progress_dialog.dart';
import 'package:cosy_contacts/presentation/widgets/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  static const String homeScreenRoute = '/home';

  final _navigator = GetIt.I<NavigatorHelper>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => HomeCubit()..getGroups(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.watch<HomeCubit>();

            return Scaffold(
              appBar: AppBar(),
              body: _buildBody(context, cubit),
            );
          },
        ),
      );

  Widget _buildBody(BuildContext context, HomeCubit cubit) {
    switch (cubit.state.loadingStatus) {
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
        return buildGroupCards(cubit.state.groups);

      case LoadingStatus.error:
        ProgressDialog.dismiss();
        return ErrorCard(
          message: cubit.state.errorMessage,
          callback: cubit.getGroups,
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
                      // Image.asset('assets/images/partners.png', height: 120.0),
                      SizedBox(
                        height: 120.0,
                        child: Center(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                'https://s1.iconbird.com/ico/1212/261/w512h5121355062233Photos512x512.png',
                          ),
                        ),
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
      );
}
