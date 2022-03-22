import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class ContactsState {
  final LoadingStatus loadingStatus;
  final List<ShortenedContactModel> contacts;
  final String errorMessage;

  ContactsState._({
    required this.loadingStatus,
    required this.contacts,
    required this.errorMessage,
  });

  factory ContactsState.initial() => ContactsState._(
        loadingStatus: LoadingStatus.never,
        contacts: [],
        errorMessage: '',
      );

  ContactsState copyWith({
    LoadingStatus? loadingStatus,
    List<ShortenedContactModel>? contacts,
    String? errorMessage,
  }) =>
      ContactsState._(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        contacts: contacts ?? this.contacts,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
