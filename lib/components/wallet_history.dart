import 'package:depositapp/api_functions.dart';
import 'package:depositapp/classes/transaction.dart';
import 'package:depositapp/components/wallet_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({super.key});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  List<dynamic> history = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // do not touch
        child: FutureBuilder(
          initialData: null,
          future: _getHistory(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data,
            );
          },
        ),
      ),
    );
  }

  Future<List<Widget>> _getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') as String;
    final String pubKey = prefs.getString('public-key') as String;

    var history = await getHistory(
      pubKey,
      token,
    );

    return history.map(
      (item) {
        String action = item['eventType'];
        String nameAction = action[0].toUpperCase() + action.substring(1).toLowerCase();
        List<String> numberOfRewardsString = item['numberOfUnitsIn'].toString().split('.');
        String finalNumber = numberOfRewardsString[0];
        if (numberOfRewardsString.length > 1){
          String decimals = numberOfRewardsString[1];
          if (decimals.length > 1){
            finalNumber = finalNumber + "." + decimals.substring(0,2);
          }
          else {
            finalNumber = finalNumber + "." + decimals[0];
          }
        }
        String answer = "+${finalNumber} ${item['unitNameIn']}";
        String time = item['eventTime'].split('T')[0];
        Transaction currentTx = Transaction(nameAction, '', time, answer);
        return TransactionItem(currentTx);
      },
    ).toList();
  }
}
