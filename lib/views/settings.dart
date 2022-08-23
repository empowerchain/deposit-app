import 'package:depositapp/login.dart';
import 'package:depositapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(104, 223, 87, 1),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.settingstitle,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          child: Column(children: [
            SizedBox(height: 40.0),
            PopupMenuButton(
              elevation: 15.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Language",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(104, 223, 87, 1),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.public)
                      ],
                    ),
                  ),
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: SizedBox(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 40, right: 40),
                    child: ListTile(
                      leading: Text(
                        "🇬🇧",
                        style: TextStyle(fontSize: 35.0),
                      ),
                      title: Text('English'),
                    ),
                  )),
                  //
                  // onTap: () => null;
                ),
                const PopupMenuItem(
                  child: SizedBox(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 40, right: 40),
                    child: ListTile(
                      leading: Text(
                        "🇵🇹",
                        style: TextStyle(fontSize: 35.0),
                      ),
                      title: Text('Portugues'),
                    ),
                  )),
                  //
                  // onTap: () => null;
                ),
              ],
            ),
          ]),
        ));
  }
}

String ellipsisAddress(address) {
  var addressSize = address.length;
  var finalAddress = address.substring(0, 15) +
      "..." +
      address.substring(addressSize - 15, addressSize);
  return finalAddress;
}
