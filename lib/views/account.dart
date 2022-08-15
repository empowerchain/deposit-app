import 'package:depositapp/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var originalAddress = "cosmos19r3jlewte0mfazu9p2u5nn9j63c8mtw0h7h2rg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.account,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              const Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 178, 177, 177),
                size: 60.0,
              ),
              const SizedBox(width: 10.0),
              Text(
                ellipsisAddress(originalAddress),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(
            height: 10,
            thickness: 1,
            endIndent: 0,
            color: Color.fromARGB(255, 211, 211, 211),
          ),
          Row(
            children: [
              const SizedBox(width: 25.0),
              const SizedBox(
                height: 50.0,
                child: ImageIcon(
                  AssetImage("assets/images/questionIcon.png"),
                  color: Color.fromRGBO(103, 224, 86, 1),
                  size: 30.0,
                ),
              ),
              const SizedBox(width: 20.0),
              Text(
                AppLocalizations.of(context)!.help,
              ),
              const Expanded(
                child: Text("   "),
              ),
              Icon(Icons.arrow_forward_ios),
              const SizedBox(width: 25.0),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            endIndent: 0,
            color: Color.fromARGB(255, 211, 211, 211),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const SizedBox(width: 25.0),
              GestureDetector(
                child: const Text(
                  "Log out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 169, 169, 169),
                  ),
                ),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear().then(
                        (value) => Navigator.pop(context),
                      );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

String ellipsisAddress(address) {
  var addressSize = address.length;
  var finalAddress = address.substring(0, 15) +
      "..." +
      address.substring(addressSize - 15, addressSize);
  return finalAddress;
}
