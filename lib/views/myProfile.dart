import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Map<String, bool> _isEnable = {
    "First Name": false,
    "Last Name": false,
    "Email": false,
  };

  Widget characteristic(String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: Row(
          children: [
            SizedBox(width: 20.0),
            Expanded(child: Text(value)),
            SizedBox(
              width: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 150.0,
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: "Festive Leave",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    enabled: _isEnable[value],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: _isEnable[value]!
                  ? Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(96, 200, 248, 1),
                      ),
                    )
                  : Text(
                      "Edit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(96, 200, 248, 1),
                      ),
                    ),
              onPressed: () => setState(
                () {
                  _isEnable[value] = !_isEnable[value]!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(104, 223, 87, 1),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.account,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              print(200);
            },
            icon: const Icon(
              Icons.send_to_mobile,
              color: Color.fromRGBO(103, 224, 86, 1),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              characteristic("First Name"),
              characteristic("Last Name"),
              characteristic("Email"),
            ],
          ),
        ],
      ),
    );
  }
}