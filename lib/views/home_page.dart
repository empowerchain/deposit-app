import 'package:deposit_app/views/account.dart';
import 'package:deposit_app/views/deposit.dart';
import 'package:deposit_app/views/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Deposit(),
    Wallet(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage("assets/images/empowerIcon.png"),
              color: null,
            ),
            label: AppLocalizations.of(context)!.deposit,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage("assets/images/walletIcon.png"),
              color: null,
            ),
            label: AppLocalizations.of(context)!.wallet,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: AppLocalizations.of(context)!.account,
          ),
        ],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: const Color.fromRGBO(93, 255, 64, 1),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
