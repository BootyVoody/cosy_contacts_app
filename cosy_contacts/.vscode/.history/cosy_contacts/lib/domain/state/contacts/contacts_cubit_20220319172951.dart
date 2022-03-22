import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final _repository = GetIt.I<ContentsRepository>();

  int queryConstraintLength = 0;

  ContactsCubit() : super(ContactsState.initial());

  void getShortenedContacts(int subgroupId) async {
    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );

    final contacts = await _repository.getShortenedContacts(subgroupId);
    if (contacts.errorMessage != null) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorMessage: contacts.errorMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.done,
        contacts: contacts.data,
        filteredContacts: contacts.data,
      ),
    );
  }

  void filter(String query) {
    switch (query.isNotEmpty) {
      case true:
        switch (query.trim().length >= queryConstraintLength) {
          case true:
            final iterator = state.filteredContacts.iterator;
            while (iterator.moveNext()) {
              if (!iterator.current.partnerName
                  .toLowerCase()
                  .contains(query.trim().toLowerCase())) {
                state.filteredContacts.remove(iterator.current);
              }
            }
            break;

          case false:
            break;
        }
        break;

      case false:
        break;
    }
  }
}
