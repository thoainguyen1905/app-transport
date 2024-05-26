import 'package:app_transport/services/transport_services.dart';
import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactOrderWidget extends StatefulWidget {
  ContactOrderWidget(
      {super.key,
      required this.item,
      required this.checkStatus,
      required this.callback,
      required this.target});
  dynamic item = {};
  String target = '';
  final Function() callback;
  bool checkStatus = false;

  @override
  State<ContactOrderWidget> createState() => _ContactOrderWidgetState();
}

class _ContactOrderWidgetState extends State<ContactOrderWidget> {
  final formatter = NumberFormat('#,##0', 'en_US');

  void changeStatus() async {
    try {
      var res = await TransportServices.changeStatus(widget.item['_id'],
          widget.target, int.parse(widget.item['status']) + 1);
      logger.w(res);
      if (res == true) {
        widget.callback();
      }
    } catch (e) {
      logger.w(e);
    }
  }

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
              Text(
                widget.item['code'].toString(),
                style: TextStyle(
                    color: ColorsConstants.backgroundMain,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${formatter.format(int.parse(widget.item['price']))}đ",
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
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
                      _launchPhoneCall('0123456789');
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
                      widget.item['description'],
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
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 221, 219, 219))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      color: ColorsConstants.backgroundMain,
                      Icons.phone,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Gọi điện')
                  ],
                ),
              )),
              widget.checkStatus
                  ? Expanded(
                      child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 221, 219, 219))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.beenhere,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Đã hoàn thành')
                        ],
                      ),
                    ))
                  : Expanded(
                      child: GestureDetector(
                      onTap: () {
                        changeStatus();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 221, 219, 219))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.forward,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Chuyển trạng thái')
                          ],
                        ),
                      ),
                    )),
            ],
          )
        ],
      ),
    );
  }
}
