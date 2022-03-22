import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class HomeState {
  final LoadingStatus loadingStatus;
  final List<GroupModel> groups;

  const HomeState._({
    required this.loadingStatus,
    required this.groups,
  });
}
