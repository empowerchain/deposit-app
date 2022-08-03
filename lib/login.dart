import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Web3Register extends StatefulWidget {
  @override
  State<Web3Register> createState() => _Web3Register();
}

class _Web3Register extends State<Web3Register> {
  String _result = '<empty>';
  bool logoutVisible = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#fff000";

    await Web3AuthFlutter.init(
      clientId:
          'BCTraDCiou6NAUmfMhvL8zS0RTfV07Tvj4iuRwhYHneJyQWakx8i6rZ12p_n021XzCcjcSdcHBY2qU-WD3MPpfA',
      network: Network.testnet,
      redirectUri: 'com.example.depositapp://auth',
      whiteLabelData: WhiteLabelData(
          dark: true, name: "flutterdepositapp", theme: themeMap),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          const Text(
            "LOG IN",
            style: TextStyle(
              color: Color.fromRGBO(104, 223, 87, 1),
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 24.0, bottom: 16.0, top: 16.0),
                fillColor: Color(0xFFF5F6F7),
                filled: true,
                border: OutlineInputBorder(),
                hintText: 'mail@empower.com',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _login(_withGoogle),
                    child: Ink.image(
                      image: const AssetImage("assets/logos/login-google.png"),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  InkWell(
                    onTap: _login(_withFacebook),
                    child: Ink.image(
                      image:
                          const AssetImage("assets/logos/login-facebook.png"),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  InkWell(
                    onTap: _login(_withTwitter),
                    child: Ink.image(
                      image: const AssetImage("assets/logos/login-twitter.png"),
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Visibility(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red // This is what you need!
                    ),
                onPressed: _logout(),
                child: const Text('Logout')),
            visible: logoutVisible,
          ),
          ElevatedButton(
            // onPressed: (() => debugPrint("QrCode")),
            onPressed: _login(_withGoogle),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(104, 223, 87, 1)),
              minimumSize: MaterialStateProperty.all<Size>(Size(300, 40)),
            ),
            child: Text(
              AppLocalizations.of(context)!.doneLogin,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          // Text('Scan result : $_scanBarcode\n',
          //     style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }

  // Functions to log in/out
  VoidCallback _login(Future<Web3AuthResponse> Function() method) {
    return () async {
      try {
        final Web3AuthResponse response = await method();
        setState(() {
          _result = response.toString();
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  VoidCallback _logout() {
    return () async {
      try {
        await Web3AuthFlutter.logout();
        setState(() {
          _result = '<empty>';
          logoutVisible = false;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  Future<Web3AuthResponse> _withGoogle() {
    return Web3AuthFlutter.login(
        provider: Provider.google, mfaLevel: MFALevel.MANDATORY);
  }

  Future<Web3AuthResponse> _withFacebook() {
    return Web3AuthFlutter.login(
        provider: Provider.facebook, mfaLevel: MFALevel.MANDATORY);
  }

  Future<Web3AuthResponse> _withTwitter() {
    return Web3AuthFlutter.login(
        provider: Provider.twitter, mfaLevel: MFALevel.MANDATORY);
  }
}
