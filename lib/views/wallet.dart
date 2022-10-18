import 'package:depositapp/api_functions.dart';
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/components/wallet_appbar.dart';
import 'package:depositapp/components/wallet_history.dart';
import 'package:depositapp/components/wallet_history_title.dart';
import 'package:elliptic/elliptic.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String publicKey = '';
  String token = '';
  double kilosCollected = 0;

  @override
  void initState() {
    super.initState();
    publicKey = UserSimplePreferences.getPublicKey();
    token = UserSimplePreferences.getToken();
    getPlasticRecord(publicKey, token).then((value) {
      List<dynamic> depositAmounts = value["depositAmounts"];
      double collectedPlastic = 0;
      for (var item in depositAmounts) {
        collectedPlastic += item["amount"];
      }
      setState(() {
        kilosCollected= collectedPlastic;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WalletAppBar(),
        const SizedBox(height: 10.0),
        WalletHistoryTitle(kilosCollected),
        const WalletHistory(),
      ],
    );
  }
}
