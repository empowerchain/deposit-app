import 'package:deposit_app/classes/voucher.dart';
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
        iconTheme: const IconThemeData(
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
            VoucherItem(
              key: UniqueKey(),
              Voucher("Coupon1", "Amazing promo 123", "123",
                  'assets/images/voucherPlaceholder.png', false),
            ),
            VoucherItem(
              key: UniqueKey(),
              Voucher("Coupon2", "Amazing promo 456", "456",
                  'assets/images/voucherPlaceholder.png', false),
            ),
            VoucherItem(
              key: UniqueKey(),
              Voucher("Coupon3", "Amazing promo 789", "789",
                  'assets/images/voucherPlaceholder.png', false),
            ),
            VoucherItem(
              key: UniqueKey(),
              Voucher("Coupon4", "Amazing promo 098", "098",
                  'assets/images/voucherPlaceholder.png', false),
            ),
            VoucherItem(
              key: UniqueKey(),
              Voucher("Coupon5", "Amazing promo 321", "321",
                  'assets/images/voucherPlaceholder.png', false),
            ),
          ],
        ),
      ),
    );
  }
}
