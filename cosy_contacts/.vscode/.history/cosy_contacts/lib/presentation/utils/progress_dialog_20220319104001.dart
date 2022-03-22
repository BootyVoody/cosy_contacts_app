import 'package:flutter/material.dart';

class ProgressDialog {
  static BuildContext? _dialogContext;

  static void show(BuildContext context, String message) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _dialogContext = context;

          return Dialog(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircularProgressIndicator(),
                  Text('Пожалуйста, подожди'),
                ],
              ),
            ),
          );
        },
      );

  static void dismiss() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext).pop();
    }
  }
}
