import 'package:app_transport/controllers/auth_controller.dart';
import 'package:app_transport/services/transport_services.dart';
import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationTransportWidget extends StatefulWidget {
  InformationTransportWidget(
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
  State<InformationTransportWidget> createState() =>
      _InformationTransportWidgetState();
}

class _InformationTransportWidgetState
    extends State<InformationTransportWidget> {
  final formatter = NumberFormat('#,##0', 'en_US');
  final UserController _userController = Get.put(UserController());
  dynamic postCurrent;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    var post = _userController.infor['post'];
    setState(() {
      var data = post.where((i) => i['code'] == '122000').toList();
      postCurrent = data[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.backgroundMain,
        centerTitle: true,
        title: const Text(
          'Giao hàng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
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
                  child: Row(
                    children: [
                      const Icon(Icons.local_shipping),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        postCurrent['address'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
