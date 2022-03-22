import 'package:cosy_contacts/domain/model/response_model.dart';
import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';

abstract class ContentsRepository {
  Future<ResponseModel<List<ShortenedContactModel>>> getShortenedContacts(
      int subgroupId);
}
