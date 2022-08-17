import 'package:depositapp/api_functions.dart';
import 'package:depositapp/classes/voucher.dart';
import 'package:depositapp/components/vouchers_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrashCan extends StatefulWidget {
  final String? token;
  final String? userPubKey;

  const TrashCan(
    this.token,
    this.userPubKey, {
    super.key,
  });

  @override
  State<TrashCan> createState() => _TrashCanState();
}

class _TrashCanState extends State<TrashCan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(104, 223, 87, 1),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myvouchersused,
          style: const TextStyle(
            color: Color.fromRGBO(104, 223, 87, 100),
          ),
        ),
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      ),
      body: FutureBuilder(
        initialData: null,
        future: _getVouchers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: const CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data,
          );
        },
      ),
    );
  }

  Future<List<Widget>> _getVouchers() async {
    final vouchersAvailable =
        await getUsedVouchersForUser(widget.userPubKey, widget.token);
    final vouchersNotUsed = vouchersAvailable;
    return vouchersNotUsed.map(
      (item) {
        Map voucherData = item["voucher"];
        Map voucherDefinition = item["voucherDefinition"];
        Voucher voucher = Voucher(
          voucherData["id"],
          voucherDefinition["name"],
          voucherData["voucherDefinitionID"],
          voucherDefinition["pictureURL"],
          voucherData["invalidated"],
        );
        return VoucherItem(voucher);
      },
    ).toList();
  }
}
