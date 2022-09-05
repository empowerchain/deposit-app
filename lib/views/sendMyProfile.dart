import 'package:depositapp/constants.dart';
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
  Map<String, bool> _isEnable = {
    "First Name": false,
    "Last Name": false,
    "Email": false,
  };

  Widget characteristic(String parameter) {
    Map<String, String> _values = {
      "First Name": widget.firstName,
      "Last Name": widget.lastName,
      "Email": widget.email,
    };

    String inputByUser = _values[parameter]!;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(width: 20.0),
          Expanded(child: Text(parameter)),
          SizedBox(
            width: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(inputByUser),
              Container(
                width: 50.0,
                child: Checkbox(
                  activeColor: Colors.transparent,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (inputByUser == "") {
                      return Colors.black38.withOpacity(.32);
                    }
                    return Color.fromRGBO(104, 223, 87, 1);
                  }),
                  checkColor: Colors.white,
                  value: inputByUser != "" ? _isEnable[parameter] : false,
                  onChanged: ((value) {
                    setState(() {
                      _isEnable[parameter] = !_isEnable[parameter]!;
                    });
                  }),
                ),
              ),
            ],
          ),
          SizedBox(
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
