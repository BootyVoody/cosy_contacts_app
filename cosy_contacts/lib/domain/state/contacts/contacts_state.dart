import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';

class ContactsState {
  final LoadingStatus loadingStatus;
  final List<ShortenedContactModel> contacts;
  final List<ShortenedContactModel> filteredContacts;
  final String errorMessage;

  ContactsState._({
    required this.loadingStatus,
    required this.contacts,
    required this.filteredContacts,
    required this.errorMessage,
  });

  factory ContactsState.initial() => ContactsState._(
        loadingStatus: LoadingStatus.never,
        contacts: [],
        filteredContacts: [],
        errorMessage: '',
      );

  ContactsState copyWith({
    LoadingStatus? loadingStatus,
    List<ShortenedContactModel>? contacts,
    List<ShortenedContactModel>? filteredContacts,
    String? errorMessage,
  }) =>
      ContactsState._(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        contacts: contacts ?? this.contacts,
        filteredContacts: filteredContacts ?? this.filteredContacts,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
