import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class HomeState {
  final LoadingStatus loadingStatus;
  final List<GroupModel> groups;
  final String errorMessage;

  HomeState._({
    required this.loadingStatus,
    required this.groups,
    required this.errorMessage,
  });

  factory HomeState.initial() => HomeState._(
        loadingStatus: LoadingStatus.never,
        groups: [],
        errorMessage: '',
      );

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    List<GroupModel>? groups,
    String? errorMessage,
  }) =>
      HomeState._(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        groups: groups ?? this.groups,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
