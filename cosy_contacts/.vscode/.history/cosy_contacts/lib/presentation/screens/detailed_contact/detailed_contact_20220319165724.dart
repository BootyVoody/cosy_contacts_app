import 'package:cosy_contacts/presentation/screens/detailed_contact/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class DetailedContact extends StatelessWidget {
  static const String route = '/detailed_contact';

  const DetailedContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: SearchTextField(
            onChanged: (query) {},
          ),
        ),
        body: ,
      );
}
