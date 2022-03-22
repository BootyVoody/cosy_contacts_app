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
