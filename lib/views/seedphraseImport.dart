import 'package:alan/proto/tendermint/p2p/types.pb.dart';
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/crypto_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeedphraseImport extends StatefulWidget {
  const SeedphraseImport({
    super.key,
  });

  @override
  State<SeedphraseImport> createState() => _SeedphraseImportState();
}

class _SeedphraseImportState extends State<SeedphraseImport> {
  bool notSeedphrase = false;
  String seed = '';
  TextEditingController seedphraseController = TextEditingController();

  Widget sendButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70.0,
          ),
          ElevatedButton(
            onPressed: () {
              List<String> mnemonic = seedphraseController.text.split(' ');
              String address = empowerAddress(mnemonic);
              print(address);
              if (address == ' ') {
                setState(() {
                  notSeedphrase = true;
                });
              } else {
                setState(() {
                  seed = address;
                });
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(104, 223, 87, 1)),
              minimumSize: MaterialStateProperty.all<Size>(const Size(300, 40)),
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(104, 223, 87, 1),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.useSeedphrase,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              height: 250,
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextField(
                    controller: seedphraseController,
                    minLines: 7,
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.writeSeedphrase,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: notSeedphrase
                  ? Text(seed) : Text(
                      AppLocalizations.of(context)!.notSeedphrase,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
            ),
            sendButton(context),
            const SizedBox(
              height: 400.0,
            ),
          ],
        ),
      ),
    );
  }
}
