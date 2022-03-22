import 'package:flutter/material.dart';

class ProgressDialog {
  static BuildContext? _dialogContext;

  static void show({
    required BuildContext context,
    required String message,
  }) {
    if (_dialogContext != null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        _dialogContext = context;

        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularProgressIndicator(),
                  Text(message),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismiss() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
