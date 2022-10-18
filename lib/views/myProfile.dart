import 'package:depositapp/api_functions.dart';
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
  bool notMail = false;
  String publicKey = '';
  String token = '';

  @override
  void initState() {
    super.initState();
    publicKey = UserSimplePreferences.getPublicKey();
    token = UserSimplePreferences.getToken();
    getOrganizationsByUser(publicKey, token);
    
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  Map<String, bool> isEnable = {
    "firstName": false,
    "lastName": false,
    "email": false,
  };

  Widget shareButton(BuildContext context) {
    return InkWell(
      onTap: () {
        int organizations = UserSimplePreferences.getOrganization().length;
        if (notMail || organizations == 0) {
          return;
        }
        String inputFirstName = firstName.text != ""
            ? firstName.text
            : UserSimplePreferences.getName();
        String inputLastName = lastName.text != "" ? lastName.text : "";
        String inputMail =
            email.text != "" ? email.text : UserSimplePreferences.getMail();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendMyProfile(
              inputFirstName,
              inputLastName,
              inputMail,
            ),
          ),
        );
      },
      child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
          child: Text(
            'Send',
            textScaleFactor: 1.2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(103, 224, 86, 1),
            ),
          )),
    );
  }

  Widget characteristic(
      String titleForRow, String id, TextEditingController input, String data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          Expanded(child: Text(titleForRow)),
          const SizedBox(
            width: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 150.0,
                child: TextField(
                  controller: input,
                  onChanged: id == "email"
                      ? (emptyParameter) {
                          bool verifyMail = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(input.text);
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
                  enabled: isEnable[id],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          TextButton(
            child: isEnable[id]!
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
                  print(isEnable);
                  isEnable[id] = !isEnable[id]!;
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget notMailMessage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Text(
            AppLocalizations.of(context)!.notmail,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16.0,
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
          AppLocalizations.of(context)!.myprofile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          shareButton(context),
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
                AppLocalizations.of(context)!.firstname,
                "firstName",
                firstName,
                UserSimplePreferences.getName(),
              ),
              characteristic(
                AppLocalizations.of(context)!.lastname,
                "lastName",
                lastName,
                UserSimplePreferences.getLastName(),
              ),
              characteristic(
                "Email",
                "email",
                email,
                UserSimplePreferences.getMail(),
              ),
              notMail ? notMailMessage() : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
