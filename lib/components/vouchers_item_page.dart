import 'package:deposit_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoucherItemPage extends StatefulWidget {
  final String name;
  final String description;
  final String code;
  final String imageUrl;
  const VoucherItemPage(this.name, this.description, this.code, this.imageUrl,
      {Key? key})
      : super(key: key);

  @override
  State<VoucherItemPage> createState() => _VoucherItemPageState();
}

class _VoucherItemPageState extends State<VoucherItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color.fromRGBO(104, 223, 87, 1),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.myvouchers,
            style: const TextStyle(
              color: Color.fromRGBO(104, 223, 87, 100),
            ),
          ),
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                widget.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20.0, 30, 0),
                child: Image.asset(
                  'assets/images/voucherPlaceholder.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "Code: ${widget.code}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              ElevatedButton(
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
                onPressed: () {},
                child: const Text(
                  'Mark as used',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
