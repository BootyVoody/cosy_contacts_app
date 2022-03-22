import 'package:cosy_contacts/domain/repository/contents_repository.dart';
import 'package:cosy_contacts/domain/state/contacts/contacts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final _repository = GetIt.I<ContentsRepository>();

  ContactsCubit() : super(ContactsState.initial());

  void getShortenedContacts() async {}
}
