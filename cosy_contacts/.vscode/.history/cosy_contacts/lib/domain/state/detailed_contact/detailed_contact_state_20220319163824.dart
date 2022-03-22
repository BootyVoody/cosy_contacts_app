import 'package:cosy_contacts/domain/model/contact_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class DetailedContactState {
  final LoadingStatus loadingStatus;
  final ContactModel? contacts;
  final String errorMessage;

  DetailedContactState._({
    required this.loadingStatus,
    required this.contacts,
    required this.errorMessage,
  });

  factory DetailedContactState.initial() => DetailedContactState._(
        loadingStatus: LoadingStatus.never,
        contacts: null,
        errorMessage: '',
      );
}
