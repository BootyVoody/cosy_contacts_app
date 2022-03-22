import 'package:cosy_contacts/domain/model/group_model.dart';
import 'package:cosy_contacts/internal/constants/transparent_image.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final GroupModel group;

  const GroupCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    'https://cdn-icons-png.flaticon.com/512/1076/1076744.png',
              ),
            ),
            Text(
              group.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
