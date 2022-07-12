import 'dart:ffi';

import 'package:deposit_app/components/vouchers_item_page.dart';
import 'package:flutter/material.dart';

class voucherItem extends StatefulWidget {
  final String name;
  final bool used;
  final String description;
  final String code;
  const voucherItem(this.name, this.used, this.description, this.code, {Key? key})
      : super(key: key);

  @override
  State<voucherItem> createState() => _voucherItemState();
}

class _voucherItemState extends State<voucherItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.used) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VoucherItemPage(
                    widget.name,
                    widget.description,
                    widget.code,
                    'assets/images/voucherPlaceholder.png')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.used
                ? Color.fromARGB(255, 182, 182, 182)
                : const Color.fromARGB(255, 255, 255, 255),
            boxShadow: const [
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
                            widget.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            widget.name,
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
