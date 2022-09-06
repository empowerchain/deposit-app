import 'dart:io';

import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:depositapp/first_instance.dart';
import 'package:depositapp/login.dart';
import 'package:depositapp/views/settingsLanguage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:depositapp/views/myProfile.dart';
import 'package:depositapp/views/underDevelopment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UserSimplePreferences.init();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  String deviceLanguage = Platform.localeName.substring(0, 2); // gets locale of device
  String currentLocale = UserSimplePreferences.getLocale(); // checks if stored locale exists

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale? locale = currentLocale != '' ? Locale(currentLocale) : Locale(deviceLanguage);
    return MaterialApp(
      title: 'Deposit App',
      home: const Scaffold(body: FirstInstance()),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => Web3Register(),
        '/homepage': (context) => const HomePage(),
        '/myProfile': (context) => const MyProfile(),
        '/language': (context) => const SettingsLanguage(),
        '/underDevelopment': (context) => const UnderDevelopment(),
      },
      locale: _locale ?? locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
