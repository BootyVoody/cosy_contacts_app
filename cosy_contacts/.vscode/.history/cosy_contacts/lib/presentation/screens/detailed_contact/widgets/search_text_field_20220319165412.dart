import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final void Function(String) onChanged;

  const SearchTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
