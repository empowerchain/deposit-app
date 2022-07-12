import 'package:deposit_app/components/vouchers_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Vouchers extends StatefulWidget {
  const Vouchers({super.key});

  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(104, 223, 87, 1),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myvouchers,
          style: const TextStyle(
            color: Color.fromRGBO(104, 223, 87, 100),
          ),
        ),
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      ),
      body: Container(
        child: ListView(
          children: [
            voucherItem(
                key: UniqueKey(), "Coupon1", true, "Amazing promo 123", "123"),
            voucherItem(
                key: UniqueKey(), "Coupon2", false, "Amazing promo 456", "456"),
            voucherItem(
                key: UniqueKey(), "Coupon3", true, "Amazing promo 789", "789"),
            voucherItem(
                key: UniqueKey(), "Coupon4", false, "Amazing promo 098", "098"),
            voucherItem(
                key: UniqueKey(), "Coupon5", true, "Amazing promo 321", "321")
          ],
        ),
      ),
    );
  }
}
