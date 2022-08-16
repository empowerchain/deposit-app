import 'package:depositapp/api_functions.dart';
import 'package:depositapp/classes/voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoucherItemPage extends StatefulWidget {
  final Voucher voucher;
  const VoucherItemPage(
    this.voucher, {
    Key? key,
  }) : super(key: key);

  @override
  State<VoucherItemPage> createState() => _VoucherItemPageState();
}

class _VoucherItemPageState extends State<VoucherItemPage> {
  bool activated = false;
  String token = '';

  @override
  void initState() {
    getPreferences().then((value) {
      token = value["token"] as String;
      activated = widget.voucher.used;
    });
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
                widget.voucher.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.voucher.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20.0, 30, 0),
                child: Image.network(
                  widget.voucher.image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "${AppLocalizations.of(context)!.code}: ${widget.voucher.code}",
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
                  backgroundColor: !activated
                      ? MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(104, 223, 87, 1))
                      : MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(100, 100, 100, 1)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(300, 40)),
                ),
                onPressed: !activated
                    ? () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(AppLocalizations.of(context)!
                                .confirmationtitle),
                            content: Text(
                                '${AppLocalizations.of(context)!.confirmationtext} ${widget.voucher.code}?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      AppLocalizations.of(context)!
                                          .confirmationno);
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .confirmationno),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await invalidateVoucher(
                                          widget.voucher.code, token)
                                      .then((value) {
                                    setState(() {
                                      activated = true;
                                    });
                                    Future.delayed(Duration(seconds: 1));
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop()
                                      ..pop();
                                  });
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .confirmationyes),
                              ),
                            ],
                          ),
                        )
                    : null,
                child: Text(
                  AppLocalizations.of(context)!.markasused,
                  style: const TextStyle(
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
