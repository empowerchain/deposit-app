import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          child: Column(children: [
            const SizedBox(
              height: 40.0,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/language"),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),  
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(children: [
                    const SizedBox(
                      width: 30.0,
                      height: 40.0,
                    ),
                    const Icon(
                      Icons.language,
                      size: 25.0,
                      color: Color.fromRGBO(103, 224, 86, 1),
                    ),
                    const SizedBox(
                      width: 10.0,
                      height: 30.0,
                    ),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ]),
                ),
              ),
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
