import 'dart:async';
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/views/voucher_obtained.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  String _scanBarcode = 'Unknown'; // Where QR info is contained
  String token = UserSimplePreferences.getToken();
  String? publicKey;

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      List scanSplit = barcodeScanRes.split('=');
      if (scanSplit.length > 1) {
        barcodeScanRes = scanSplit[1];
        setState(
          () {
            _scanBarcode = barcodeScanRes;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VoucherObtained(barcodeScanRes, token),
              ),
            );
          },
        );
      } else {
        barcodeScanRes = '';
        setState(
          () {
            _scanBarcode = barcodeScanRes;
          },
        );
      }
    } on PlatformException {
      barcodeScanRes = '';
      setState(
        () {
          _scanBarcode = barcodeScanRes;
        },
      );
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => scanQR(),
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
                AppLocalizations.of(context)!.claimDepositReward,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            // Text('Scan result : $_scanBarcode\n',
            //     style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
