import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/domain/model/response_model.dart';
import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/domain/repository/group_repository.dart';
import 'package:get_it/get_it.dart';

class GroupRepositoryImpl extends GroupRepository {
  final _backendApi = GetIt.I<BackendApi>();

  @override
  Future<ResponseModel<List<GroupModel>>> getGroups() async {
    try {
      final response = await _backendApi.getGroups();
      if (response == null) {
        return ResponseModel(errorMessage: 'Ответ пришёл совсем пустым )^:');
      }

      final groups = <GroupModel>[];
      for (final group in response) {
        groups.add(group.toModel());
      }

      
    }
  }
}
