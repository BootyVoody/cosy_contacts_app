import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedContactCubit extends Cubit<DetailedContactState> {
  DetailedContactCubit() : super(DetailedContactState.initial());
}
