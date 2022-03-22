import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:flutter/material.dart';

class ShortenedContactCard extends StatelessWidget {
  final ShortenedContactModel contact;
  final VoidCallback callback;

  const ShortenedContactCard({
    Key? key,
    required this.contact,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container();
}
