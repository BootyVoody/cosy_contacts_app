import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class HomeState {
  final LoadingStatus loadingStatus;
  final List<GroupModel> groups;

  HomeState._({
    required this.loadingStatus,
    required this.groups,
  });

  factory HomeState.initial() => HomeState._(
        loadingStatus: LoadingStatus.never,
        groups: [],
      );

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    List<GroupModel>? groups,
  }) =>
      HomeState._(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        groups: groups ?? this.groups,
      );
}
