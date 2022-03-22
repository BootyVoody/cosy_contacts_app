import 'package:cosy_contacts/data/dto/contact_dto.dart';
import 'package:cosy_contacts/data/dto/group_dto.dart';
import 'package:cosy_contacts/data/dto/shortened_contact_dto.dart';
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
    final result = await _dio.get<List>(
      URLs.getSubgroups,
      queryParameters: {'groupId': groupId},
    );

    return result.data
        ?.map((item) => GroupDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<ShortenedContactDto>?> getSubgroupContents(
    int subgroupId,
  ) async {
    final result = await _dio.get<List>(
      URLs.getContacts,
      queryParameters: {'subgroupId': subgroupId},
    );

    return result.data
        ?.map(
          (item) => ShortenedContactDto.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<ContactDto> getDetailedContact(int contactId) async {
    final result = await _dio.get(
      URLs.baseUrl
    )
  }
}
