import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class SubgroupsState {
  final LoadingStatus loadingStatus;
  final List<GroupModel> groups;
  final String errorMessage;

  SubgroupsState._({});
}