import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletHistoryTitle extends StatelessWidget {
  const WalletHistoryTitle({Key? key}) : super(key: key);

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
                  child: Text(
                    AppLocalizations.of(context)!.history,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 23.0,
                    ),
                  ),
                ),
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
