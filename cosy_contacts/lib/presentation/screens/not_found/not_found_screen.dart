import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: const Color(0xFFFFDA4D),
          child: const Center(
            child: Text(
              'Ой..\nЧто-то пошло совсем не так )^:',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
