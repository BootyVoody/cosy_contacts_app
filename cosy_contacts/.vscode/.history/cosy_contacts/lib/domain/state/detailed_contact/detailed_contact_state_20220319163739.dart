import 'package:cosy_contacts/domain/model/contact_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class DetailedContactState {
  final LoadingStatus loadingStatus;
  final ContactModel contacts;
  final String errorMessage;
}
