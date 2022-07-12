import 'package:deposit_app/dumb_data.dart';
import 'package:flutter/material.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({super.key});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  Widget transaction(Map<dynamic, dynamic> data) {
    String action = data["action"].toString();
    String details = data["details"].toString();
    String date = data["date"].toString();
    String result = data["result"].toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details,
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      action,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 155, 155, 155)),
                    ),
                  ],
                ),
                Text(
                  result,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(103, 224, 86, 1),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
              thickness: 1,
              endIndent: 0,
              color: Color.fromARGB(255, 155, 155, 155),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container( // do not touch
        child: ListView(
          shrinkWrap: true,
          children: data.map<Widget>((order) {
            return (transaction(order));
          }).toList(),
        ),
      ),
    );
  }
}
