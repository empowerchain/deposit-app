import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/views/underDevelopment.dart';
import 'package:depositapp/views/vouchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletAppBar extends StatefulWidget {
  const WalletAppBar({super.key});

  @override
  State<WalletAppBar> createState() => _WalletAppBarState();
}

class _WalletAppBarState extends State<WalletAppBar> {
  String token = UserSimplePreferences.getToken();
  String userPubKey = UserSimplePreferences.getPublicKey();

  Widget textWallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 30.0, 30.0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.mywallet,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Total \$MPWR",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
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
        buttonWidget(
          context,
          "assets/images/scanIcon.png",
          AppLocalizations.of(context)!.send,
          UnderDevelopment(),
        ),
        buttonWidget(
          context,
          "assets/images/qrIcon.png",
          AppLocalizations.of(context)!.receive,
          UnderDevelopment(),
        ),
        buttonVouchers(
          context,
          "assets/images/voucherIcon.png",
          AppLocalizations.of(context)!.voucher,
        ),
      ],
    );
  }

  Widget buttonWidget(BuildContext context, final String asset,
      final String title, Widget nextView) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextView),
        );
      },
      child: Padding(
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
      ),
    );
  }

  Widget buttonVouchers(
      BuildContext context, final String asset, final String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Vouchers(token, userPubKey)),
        );
      },
      child: Padding(
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
