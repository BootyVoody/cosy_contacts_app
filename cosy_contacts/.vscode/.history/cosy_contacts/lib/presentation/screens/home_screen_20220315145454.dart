import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Категории'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Партнеры'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
            ListTile(
              title: const Text('Сотрудники'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      );
}
