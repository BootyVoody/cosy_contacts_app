import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_state.dart';
import 'package:cosy_contacts/internal/constants/loading_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DetailedContactCubit extends Cubit<DetailedContactState> {
  final _repository = GetIt.I<ContentsRepository>();

  DetailedContactCubit() : super(DetailedContactState.initial());

  void getDetailedContact(int contactId) async {
    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );

    final contact = await _repository.getDetailedContact(contactId);
    if (contact.errorMessage != null) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorMessage: contact.errorMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.done,
        contacts: contact.data,
      ),
    );
  }
}
