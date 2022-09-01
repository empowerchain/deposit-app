import 'package:depositapp/views/sendMyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String name = '';
  String email = '';
  bool notMail = false;

  Map<String, TextEditingController> controllers = {
    "First Name": TextEditingController(),
    "Last Name": TextEditingController(),
    "Email": TextEditingController()
  };

  Map<String, bool> _isEnable = {
    "First Name": false,
    "Last Name": false,
    "Email": false,
  };

  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        name = value.getString("name") as String;
        email = value.getString("email") as String;
      });
    });
  }

  Widget characteristic(String value, String data) {
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
                  controller: controllers[data],
                  onChanged: value == "Email"
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
            onPressed: () {
              setState(
                () {
                  _isEnable[value] = !_isEnable[value]!;
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
              String firstName = controllers["First Name"]!.text == "" ? name : controllers["First Name"]!.text;
              String lastName = controllers["Last Name"]!.text;
              String mail = controllers["Email"]!.text == "" ? email : controllers["Email"]!.text;
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
              characteristic(AppLocalizations.of(context)!.firstname, name),
              characteristic(AppLocalizations.of(context)!.lastname, ""),
              characteristic("Email", email),
              notMail ? Text("sup") : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
