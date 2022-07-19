import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoucherObtained extends StatefulWidget {
  final String code;
  const VoucherObtained(this.code, {super.key});

  @override
  State<VoucherObtained> createState() => _VoucherObtainedState();
}

class _VoucherObtainedState extends State<VoucherObtained> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Padding(
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
                width: MediaQuery.of(context).size.width-50,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.congratulations,
            ),
            Text(widget.code),
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
