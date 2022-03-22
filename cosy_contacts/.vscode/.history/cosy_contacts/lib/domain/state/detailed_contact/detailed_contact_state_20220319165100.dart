import 'package:cosy_contacts/domain/model/contact_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class DetailedContactState {
  final LoadingStatus loadingStatus;
  final ContactModel? contact;
  final String errorMessage;

  DetailedContactState._({
    required this.loadingStatus,
    required this.contact,
    required this.errorMessage,
  });

  factory DetailedContactState.initial() => DetailedContactState._(
        loadingStatus: LoadingStatus.never,
        contact: null,
        errorMessage: '',
      );

  DetailedContactState copyWith({
    LoadingStatus? loadingStatus,
    ContactModel? contacts,
    String? errorMessage,
  }) =>
      DetailedContactState._(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        contact: contacts ?? this.contact,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
