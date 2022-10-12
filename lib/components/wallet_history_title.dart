import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletHistoryTitle extends StatefulWidget {
  final double kilos;
  const WalletHistoryTitle(
    this.kilos, {
    super.key,
  });

  @override
  State<WalletHistoryTitle> createState() => _WalletHistoryTitleState();
}

class _WalletHistoryTitleState extends State<WalletHistoryTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.history,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 23.0,
                          ),
                        ),
                        Spacer(), // use Spacer
                        Text(
                          "${AppLocalizations.of(context)!.total} ${widget.kilos} kg",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    )),
                const Divider(
                  height: 10,
                  thickness: 1,
                  endIndent: 0,
                  color: Color.fromARGB(255, 211, 211, 211),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
