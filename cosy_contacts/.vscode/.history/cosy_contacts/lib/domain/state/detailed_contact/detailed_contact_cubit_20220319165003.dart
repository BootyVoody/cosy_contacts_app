import 'package:cosy_contacts/domain/state/detailed_contact/detailed_contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DetailedContactCubit extends Cubit<DetailedContactState> {
  final repository = GetIt.I<>();

  DetailedContactCubit() : super(DetailedContactState.initial());
}
