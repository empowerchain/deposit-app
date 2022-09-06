import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/views/sendMyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String name = UserSimplePreferences.getName();
  String email = UserSimplePreferences.getMail();
  bool notMail = false;

  Map<String, TextEditingController> controllers = {
    "firstName": TextEditingController(),
    "lastName": TextEditingController(),
    "email": TextEditingController()
  };

  Map<String, bool> _isEnable = {
    "firstName": false,
    "lastName": false,
    "email": false,
  };

  Widget characteristic(String className, String value, String data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          Expanded(child: Text(value)),
          const SizedBox(
            width: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 150.0,
                child: TextField(
                  controller: controllers[data],
                  onChanged: className == "email"
                      ? (String input) {
                          bool verifyMail = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(input);
                          if (!verifyMail) {
                            setState(() {
                              notMail = true;
                            });
                          } else {
                            setState(() {
                              notMail = false;
                            });
                          }
                        }
                      : null,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: data,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  enabled: _isEnable[value],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          TextButton(
            child: _isEnable[className]!
                ? Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(96, 200, 248, 1),
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.edit,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(96, 200, 248, 1),
                    ),
                  ),
            onPressed: () {
              setState(
                () {
                  _isEnable[className] = !_isEnable[className]!;
                },
              );
            },
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
          AppLocalizations.of(context)!.myprofile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              String firstName = controllers["firstName"]!.text == ""
                  ? name
                  : controllers["firstName"]!.text;
              String lastName = controllers["lastName"]!.text;
              String mail = controllers["email"]!.text == ""
                  ? email
                  : controllers["email"]!.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SendMyProfile(firstName, lastName, mail),
                ),
              );
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
              characteristic(
                  "firstName", AppLocalizations.of(context)!.firstname, name),
              characteristic(
                  "lastName", AppLocalizations.of(context)!.lastname, ""),
              characteristic("email", "Email", email),
              notMail ? Text("sup") : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
