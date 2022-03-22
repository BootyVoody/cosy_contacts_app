import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final _repository = GetIt.I<ContentsRepository>();

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
      ),
    );
  }

  void filter(String query) {
    switch (query.isNotEmpty) {
      case true:
        switch (query.trim())
        break;

      case false:
        break;
    }
  }
}
