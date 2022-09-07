// ignore: file_names
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final Map<String, bool> isEnable = {
    "firstName": false,
    "lastName": false,
    "email": false,
  };

  Widget sendButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70.0,
          ),
          ElevatedButton(
            onPressed: () {
              Map<String, String> output = {
                "firstName": "",
                "lastName": "",
                "email": "",
              };
              if (widget.firstName != "" && isEnable["firstName"]!) {
                output["firstName"] = widget.firstName;
                UserSimplePreferences.setName(widget.firstName);
              }
              if (widget.lastName != "" && isEnable["lastName"]!) {
                output["lastName"] = widget.lastName;
                UserSimplePreferences.setLastName(widget.lastName);
              }
              if (widget.email != "" && isEnable["email"]!) {
                output["email"] = widget.email;
                UserSimplePreferences.setMail(widget.email);
              }
              print(output);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(104, 223, 87, 1)),
              minimumSize: MaterialStateProperty.all<Size>(const Size(300, 40)),
            ),
            child: Text(
              AppLocalizations.of(context)!.sharemyprofile,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget organization(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20.0),
        Expanded(
            child: Text(
          "Organization",
          style: const TextStyle(
            fontSize: 15,
          ),
        )),
        const SizedBox(
          width: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Temporarily Not Available",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 35,
        ),
      ],
    );
  }

  Widget characteristic(String parameter, String id) {
    Map<String, String> values = {
      "firstName": widget.firstName,
      "lastName": widget.lastName,
      "email": widget.email,
    };
    String inputByUser = values[id]!;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          Expanded(
              child: Text(
            parameter,
            style: const TextStyle(
              fontSize: 15,
            ),
          )),
          const SizedBox(
            width: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                inputByUser,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 50.0,
                child: Checkbox(
                  activeColor: Colors.transparent,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (inputByUser == "") {
                      return Colors.black38.withOpacity(.32);
                    }
                    return const Color.fromRGBO(104, 223, 87, 1);
                  }),
                  checkColor: Colors.white,
                  value: inputByUser != "" ? isEnable[id] : false,
                  onChanged: ((value) {
                    setState(() {
                      isEnable[id] = !isEnable[id]!;
                    });
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
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
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50.0),
          organization(context),
          const SizedBox(height: 50.0),
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              characteristic(
                  AppLocalizations.of(context)!.firstname, 'firstName'),
              characteristic(
                  AppLocalizations.of(context)!.lastname, 'lastName'),
              characteristic("Email", 'email'),
              sendButton(context)
            ],
          ),
        ],
      ),
    );
  }
}
