import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletAppBar extends StatefulWidget {
  const WalletAppBar({super.key});

  @override
  State<WalletAppBar> createState() => _WalletAppBarState();
}

class _WalletAppBarState extends State<WalletAppBar> {
  Widget textWallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 30.0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.mywallet,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Total \$MPWR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              "300.00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonsWallet(BuildContext context) {
    return Row(
      children: [
        buttonWidget(context, "assets/images/scanIcon.png",
            AppLocalizations.of(context)!.send),
        buttonWidget(context, "assets/images/qrIcon.png",
            AppLocalizations.of(context)!.receive),
        buttonWidget(context, "assets/images/voucherIcon.png",
            AppLocalizations.of(context)!.voucher),
      ],
    );
  }

  Widget buttonWidget(
      BuildContext context, final String asset, final String title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.white,
            height: 70.0,
            width: 70.0,
          ),
          Column(
            children: [
              ImageIcon(
                AssetImage(asset),
                color: const Color.fromRGBO(104, 223, 87, 100),
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonWidget2(
      BuildContext context, final String asset, final String title) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      color: Colors.white,
      child: SizedBox(
        height: 95.0,
        width: 95.0,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                ImageIcon(
                  AssetImage(asset),
                  color: const Color.fromRGBO(104, 223, 87, 100),
                ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(104, 223, 87, 1),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            textWallet(context),
            const SizedBox(height: 15.0),
            buttonsWallet(context),
          ],
        ),
      ),
    );
  }
}
