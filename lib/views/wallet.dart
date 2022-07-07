import 'package:deposit_app/components/wallet_appbar.dart';
import 'package:deposit_app/components/wallet_history.dart';
import 'package:deposit_app/components/wallet_history_title.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        WalletAppBar(),
        SizedBox(height: 10.0),
        walletHistoryTitle(),
        WalletHistory(),
      ],
    );
  }
}
