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
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      widget.onChanged(_textFieldController.text);
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: 'Поиск..'),
      );
}
