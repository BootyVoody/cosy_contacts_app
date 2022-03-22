import 'package:cosy_contacts/data/dto/group_dto.dart';
import 'package:dio/dio.dart';

class BackedApi {
  final String _defaultBaseUrl = 'http://192.168.1.111:3535';

  final Dio _dio;

  BackedApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  Future<List<GroupDto>> getGroups() async {
    final result = await _dio.get("/api/v1/groups/get");
  }
}
