import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String text;

  const InfoCard({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              Text(text),
            ],
          ),
        ),
      );
}
