import 'package:cosy_contacts/data/api/backend_api.dart';
import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:get_it/get_it.dart';

class ContentsRepositoryImpl extends ContentsRepository {
  final _backendApi = GetIt.I<BackendApi>();
}
