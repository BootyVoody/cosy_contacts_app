import 'package:cosy_contacts/data/dto/group_dto.dart';
import 'package:cosy_contacts/internal/constants/urls.dart';
import 'package:dio/dio.dart';

class BackendApi {
  final Dio _dio;

  BackendApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  Future<List<GroupDto>?> getGroups() async {
    final result = await _dio.get<List>(URLs.getGroups);
    return result.data
        ?.map((item) => GroupDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<GroupDto>?> getSubgroups(int groupId) async {
    final result = await _dio
        .get<List>(URLs.getSubgroups, queryParameters: {'groupId': groupId});
    return result.data
        ?.map((item) => GroupDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
