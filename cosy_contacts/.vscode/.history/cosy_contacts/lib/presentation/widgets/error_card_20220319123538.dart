import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback callback;

  const ErrorCard({
    Key? key,
    required this.message,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
