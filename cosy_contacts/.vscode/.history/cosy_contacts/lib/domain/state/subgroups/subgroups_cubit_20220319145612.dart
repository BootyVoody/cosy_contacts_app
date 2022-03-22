import 'package:cosy_contacts/domain/repository/group_repository.dart';
import 'package:cosy_contacts/domain/state/subgroups/subgroups_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SubgroupsCubit extends Cubit<SubgroupsState> {
  final _repository = GetIt.I<GroupRepository>();

  SubgroupsCubit() : super(SubgroupsState.initial());

  void getSubgroups(int groupId) async {
    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );

    final groups = await _repository.getSubgroups(groupId);
    if (groups.errorMessage != null) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorMessage: groups.errorMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.done,
        groups: groups.data,
      ),
    );
  }
}
