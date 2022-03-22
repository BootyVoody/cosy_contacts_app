import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/model/response_model.dart';

abstract class GroupRepository {
  Future<ResponseModel<List<GroupModel>>> getGroups();

  Future<ResponseModel<List<GroupModel>>> getSubgroups();
}
