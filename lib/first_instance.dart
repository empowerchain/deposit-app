import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/login.dart';
import 'package:depositapp/views/home_page.dart';
import 'package:flutter/material.dart';

class FirstInstance extends StatefulWidget {
  const FirstInstance({Key? key}) : super(key: key);

  @override
  State<FirstInstance> createState() => _FirstInstanceState();
}

class _FirstInstanceState extends State<FirstInstance> {
  bool userAvailable = false;
  bool languageAdded = false;
  String currentLocale = 'en';

  @override
  void initState() {
    super.initState();
    userAvailable = UserSimplePreferences.getUsername() != '';
    languageAdded = UserSimplePreferences.getLocale() != '';
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? const HomePage() : const Web3Register();
  }
}
