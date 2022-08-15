import 'package:depositapp/crypto_functions.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elliptic/elliptic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Web3Register extends StatefulWidget {
  @override
  State<Web3Register> createState() => _Web3Register();
}

class _Web3Register extends State<Web3Register> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var mailController = TextEditingController();
  String? _result;
  String _mail = '';
  String _name = '';

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
      network: Network.mainnet,
      redirectUri: 'io.empowerchain.depositapp://auth',
      whiteLabelData: WhiteLabelData(
          dark: true, name: "flutterdepositapp", theme: themeMap),
    );
  }

  Widget buttonLogo(String assetImage, void Function() networkFunction) {
    return InkWell(
      onTap: networkFunction,
      child: Ink.image(
        image: AssetImage(assetImage),
        width: 60,
        height: 60,
      ),
    );
  }

  Widget infoSeparator(String message) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 34.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              message,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 60.0,
          ),
          const Text(
            "LOG IN",
            style: TextStyle(
                color: Color.fromRGBO(104, 223, 87, 1),
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: infoSeparator(
              AppLocalizations.of(context)!.socialNetworks,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonLogo(
                    "assets/logos/login-google.png", _login(_withGoogle)),
                const SizedBox(
                  width: 30.0,
                ),
                buttonLogo(
                    "assets/logos/login-facebook.png", _login(_withFacebook)),
                const SizedBox(
                  width: 30.0,
                ),
                buttonLogo(
                    "assets/logos/login-twitter.png", _login(_withTwitter)),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: infoSeparator("Use email"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextField(
              controller: mailController,
              onChanged: (text) {
                _mail = text;
              },
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 20.0, bottom: 8.0, top: 8.0),
                fillColor: Color(0xFFF5F6F7),
                filled: true,
                border: InputBorder.none,
                hintText: 'mail@empower.com',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50.0, // <-
            child: SizedBox.expand(
              child: ElevatedButton(
                // onPressed: (() => debugPrint("QrCode")),
                onPressed: _login(_withMail),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(104, 223, 87, 1)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.doneLogin,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Functions to log in/out
  VoidCallback _login(Future<Web3AuthResponse> Function() method) {
    return () async {
      try {
        final Web3AuthResponse response = await method();
        final prefs = await SharedPreferences.getInstance();
        var privKey = response.privKey;
        var ec = getS256();
        var privHex = PrivateKey.fromHex(ec, privKey);
        var pubKey = privHex.publicKey.toCompressedHex();
        String authToken = createToken(privKey);
        await prefs.setString('token', authToken);
        await prefs.setString('public-key', pubKey);
        setState(() {
          _result = prefs.getString('token');
          _mail = response.userInfo.email.toString();
          _name = response.userInfo.name.toString();
        });
        await Navigator.pushNamed(context, "/homepage");
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

  Future<Web3AuthResponse> _withMail() {
    return Web3AuthFlutter.login(
      provider: Provider.email_passwordless,
      mfaLevel: MFALevel.MANDATORY,
      extraLoginOptions: ExtraLoginOptions(login_hint: _mail),
    );
  }
}
