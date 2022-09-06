import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsLanguage extends StatefulWidget {
  const SettingsLanguage({super.key});

  @override
  State<SettingsLanguage> createState() => _SettingsLanguageState();
}

class _SettingsLanguageState extends State<SettingsLanguage> {
  Widget languageOption(
      BuildContext context, String flag, String language, String locale) {
    return Column(children: [
      InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(children: [
              const SizedBox(
                width: 20.0,
                height: 40.0,
              ),
              const SizedBox(
                width: 10.0,
                height: 30.0,
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: flag, style: const TextStyle(fontSize: 25))
                ]),
              ),
              const SizedBox(
                width: 10.0,
                height: 30.0,
              ),
              Text(
                language,
                style: const TextStyle(fontSize: 16),
              ),
            ]),
          ),
        ),
        onTap: () {
          UserSimplePreferences.setLocale(locale); // True = Language setted
          MyApp.setLocale(context, Locale(locale));
        },
      ),
      const SizedBox(
        height: 20.0,
      )
    ]);
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
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          child: Column(children: [
            const SizedBox(
              height: 40.0,
            ),
            languageOption(context, "🇬🇧", "English", "en"),
            languageOption(context, "🇵🇹", "Portuguese", "pt"),
          ]),
        ));
  }
}

String ellipsisAddress(address) {
  var addressSize = address.length;
  var finalAddress = address.substring(0, 15) +
      "..." +
      address.substring(addressSize - 15, addressSize);
  return finalAddress;
}
