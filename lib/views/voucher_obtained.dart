import 'package:deposit_app/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherObtained extends StatefulWidget {
  final String code;
  final String token;
  const VoucherObtained(
    this.code,
    this.token, {
    super.key,
  });

  @override
  State<VoucherObtained> createState() => _VoucherObtainedState();
}

class _VoucherObtainedState extends State<VoucherObtained> {
  Map<String, dynamic> content = {};
  String publicKey = '';
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        publicKey = value.getString("public-key") as String;
      });

      depositClaim(widget.token, publicKey, widget.code).then(
        (value) {
          setState(() {
            content = value;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                'assets/images/receive_voucher.png',
                width: MediaQuery.of(context).size.width - 50,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.congratulations,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(widget.code),
            const SizedBox(
              height: 80.0,
            ),
            ElevatedButton(
              // onPressed: (() => debugPrint("QrCode")),
              onPressed: () => Navigator.pop(context),
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
                AppLocalizations.of(context)!.done,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
