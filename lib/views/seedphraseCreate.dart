import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/crypto_functions.dart';
import 'package:depositapp/views/seedphraseAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class SeedphraseCreate extends StatefulWidget {
  const SeedphraseCreate({
    super.key,
  });

  @override
  State<SeedphraseCreate> createState() => _SeedphraseCreateState();
}

class _SeedphraseCreateState extends State<SeedphraseCreate> {
  List<String> mnemonic = generateSeedphrase();
  int index = 0;

  Widget Button(BuildContext context, void Function() command, String text) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: command,
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
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  Widget WordBlock(BuildContext context, int index, String word) {
    return SizedBox(
      width: 110,
      height: 60,
      child: Center(
        child: Text(
          "$index. $word",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  getMnemonic() async {
    await Clipboard.setData(ClipboardData(text: mnemonic.join(" ")));
  }

  remakeMnemonic() {
    index = 0; // needed for when the seedphrase is regenerated
    List<String> newMnemonic = generateSeedphrase();
    setState(() {
      mnemonic = newMnemonic;
      List<Widget> words = [];
      mnemonic.forEach((word) {
        index++; // raises index
        return words.add(WordBlock(context, index, word));
      });
    });
  }

  confirmMnemonic() {
    print(200);
    return showDialog(
        context: context, builder: (_) => const AcceptSeedphrase());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    index = 0;
    mnemonic.forEach((word) {
      index++;
      return words.add(WordBlock(context, index, word));
    });

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(104, 223, 87, 1), spreadRadius: 5),
                ],
              ),
              height: 272,
              width: 362,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: words.sublist(0, 3),
                    ),
                    Row(
                      children: words.sublist(3, 6),
                    ),
                    Row(
                      children: words.sublist(6, 9),
                    ),
                    Row(
                      children: words.sublist(9),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Button(
                    context,
                    getMnemonic,
                    AppLocalizations.of(context)!.copySeedphrase,
                  ),
                  Button(
                    context,
                    remakeMnemonic,
                    AppLocalizations.of(context)!.changeSeedphrase,
                  ),
                  Button(context, confirmMnemonic,
                      AppLocalizations.of(context)!.login),
                ],
              ),
            ),
            const SizedBox(
              height: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
