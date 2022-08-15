import 'package:depositapp/components/wallet_transaction_item.dart';
import 'package:depositapp/dumb_data.dart';
import 'package:flutter/material.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({super.key});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container( // do not touch
        child: ListView(
          shrinkWrap: true,
          children: data.map<Widget>((order) {
            return (TransactionItem(order));
          }).toList(),
        ),
      ),
    );
  }
}
