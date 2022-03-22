import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/data/repository/util/handle_http_error.dart';
import 'package:cosy_contacts/domain/model/contact_model.dart';
import 'package:cosy_contacts/domain/model/response_model.dart';
import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ContentsRepositoryImpl extends ContentsRepository {
  final _backendApi = GetIt.I<BackendApi>();

  @override
  Future<ResponseModel<List<ShortenedContactModel>>> getShortenedContacts(
      int subgroupId) async {
    try {
      final response = await _backendApi.getSubgroupContents(subgroupId);
      if (response == null) {
        return ResponseModel(errorMessage: 'Ответ пришёл совсем пустым )^:');
      }

      final contacts = <ShortenedContactModel>[];
      for (final contact in response) {
        contacts.add(contact.toModel());
      }

      return ResponseModel(data: contacts);
    } on DioError catch (e) {
      return handleHttpError(e);
    }
  }

  @override
  Future<ResponseModel<ContactModel>> getDetailedContact(int contactId) async {
    try {
      final response = await _backendApi.getDetailedContact(contactId);
      return ResponseModel(data: response.toModel());
    } on DioError catch (e) {
      return handleHttpError(e);
    }
  }
}
