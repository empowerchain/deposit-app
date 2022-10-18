import 'package:depositapp/api_functions.dart';
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:flutter/material.dart';

class DropdownOrganizations extends StatefulWidget {
  const DropdownOrganizations({super.key});

  @override
  State<DropdownOrganizations> createState() => _DropdownOrganizationsState();
}

class _DropdownOrganizationsState extends State<DropdownOrganizations> {
  List<String> organizations = UserSimplePreferences.getOrganization();
  String chosenOrganization = "";

  @override
  void initState() {
    super.initState();
    chosenOrganization = organizations[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: chosenOrganization,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
        color: Color.fromRGBO(93, 255, 64, .7),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          chosenOrganization = value!;
        });
      },
      items: organizations.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
