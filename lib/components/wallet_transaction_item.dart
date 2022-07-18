import 'package:deposit_app/classes/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  const TransactionItem(this.transaction,
      {Key? key})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(200);
        },
        child: Padding(
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
                          widget.transaction.details,
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          widget.transaction.action,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          widget.transaction.date,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 155, 155, 155)),
                        ),
                      ],
                    ),
                    Text(
                      widget.transaction.result,
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
        ));
  }
}
