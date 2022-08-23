import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMyProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const SendMyProfile(
    this.firstName,
    this.lastName,
    this.email, {
    super.key,
  });

  @override
  State<SendMyProfile> createState() => _SendMyProfileState();
}

class _SendMyProfileState extends State<SendMyProfile> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Map<String, bool> _isEnable = {
    "First Name": false,
    "Last Name": false,
    "Email": false,
  };

  Widget characteristic(String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(96, 200, 248, 1),
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.edit,
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
          AppLocalizations.of(context)!.sharemyprofile,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
              characteristic(AppLocalizations.of(context)!.firstname),
              characteristic(AppLocalizations.of(context)!.lastname),
              characteristic("Email"),
            ],
          ),
        ],
      ),
    );
  }
}
