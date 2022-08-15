import 'package:depositapp/classes/voucher.dart';
import 'package:depositapp/components/vouchers_item_page.dart';
import 'package:flutter/material.dart';

class VoucherItem extends StatefulWidget {
  final Voucher voucher;
  const VoucherItem(this.voucher, {Key? key}) : super(key: key);

  @override
  State<VoucherItem> createState() => _VoucherItemState();
}

class _VoucherItemState extends State<VoucherItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherItemPage(
                widget.voucher.name,
                widget.voucher.description,
                widget.voucher.code,
                widget.voucher.image),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 188, 188, 188),
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20.0, 30, 0),
                child: Image.asset(
                  'assets/images/voucherPlaceholder.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.voucher.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            widget.voucher.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
