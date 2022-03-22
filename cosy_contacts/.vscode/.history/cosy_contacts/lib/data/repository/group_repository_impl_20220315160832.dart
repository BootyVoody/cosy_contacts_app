import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/domain/model/response_model.dart';
import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/repository/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
  final BackendApi _backendApi;

  GroupRepositoryImpl(this._backendApi);

  @override
  Future<ResponseModel<List<GroupModel>>> getGroups() async {
    try {
      final response = await _backendApi.getGroups();
      return ResponseModel(data: data, errorMessage: errorMessage)
    }
  }
}
