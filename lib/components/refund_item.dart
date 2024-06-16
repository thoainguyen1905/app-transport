import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RefundItemWidget extends StatefulWidget {
  RefundItemWidget({super.key, required this.item, required this.reason});
  dynamic item;
  String reason = '';

  @override
  State<RefundItemWidget> createState() => _RefundItemWidgetState();
}

class _RefundItemWidgetState extends State<RefundItemWidget> {
  final formatter = NumberFormat('#,##0', 'en_US');
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  widget.item['code'].toString(),
                  style: TextStyle(
                      color: ColorsConstants.backgroundMain,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Text(
              //   "${formatter.format(int.parse(widget.item['price']))}đ",
              //   style: const TextStyle(
              //       color: Colors.green,
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600),
              // )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.storefront),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.item['shopName'].toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Gọi shop'),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchPhoneCall(widget.item['phoneShop']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorsConstants.backgroundMain,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.perm_identity),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.item['receiver'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      widget.item['address'],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.description),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      widget.reason,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.checklist),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      widget.item['type'],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
