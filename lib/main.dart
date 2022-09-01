import 'package:depositapp/login.dart';
import 'package:depositapp/views/myProfile.dart';
import 'package:depositapp/views/underDevelopment.dart';
import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale language = const Locale('en');

    return MaterialApp(
      title: 'Deposit App',
      home: Scaffold(body: Web3Register()),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => Web3Register(),
        '/homepage': (context) => const HomePage(),
        '/myProfile': (context) => const MyProfile(),
        '/underDevelopment': (context) => const UnderDevelopment(),
      },
      locale: language,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', ''), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
