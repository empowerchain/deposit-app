import 'package:depositapp/login.dart';
import 'package:depositapp/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstInstance extends StatefulWidget {
  const FirstInstance({Key? key}) : super(key: key);

  @override
  State<FirstInstance> createState() => _FirstInstanceState();
}

class _FirstInstanceState extends State<FirstInstance> {
  bool userAvailable = false;
  bool languageAdded = false;
  
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userAvailable = value.getString("public-key") != null; // True = User logged
        languageAdded = value.getString("language") != null; // True = Language setted
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? Web3Register() : const HomePage();
  }
}
