import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';
import 'package:flutter/material.dart';

class ShortenedContactCard extends StatelessWidget {
  final ShortenedContactModel contact;
  final VoidCallback onTap;

  const ShortenedContactCard({
    Key? key,
    required this.contact,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4.0,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.partnerName),
                Text(contact.serviceName),
                const SizedBox(height: 8.0),
              ],
            ),
            subtitle: Text(contact.partnerTel),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ),
        ),
      );
}
