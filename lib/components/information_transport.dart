import 'package:app_transport/components/item_call.dart';
import 'package:app_transport/controllers/auth_controller.dart';
import 'package:app_transport/screens/home/widgets/detail_order.dart';
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
  bool refund = false;
  final UserController _userController = Get.put(UserController());
  final TextEditingController _reasonController = TextEditingController();
  dynamic postCurrent;
  List<dynamic> listHistoryCall = [];
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

  void getDetail() async {
    try {
      var res = await TransportServices.getDetailDelivery(
          widget.item['_id'], widget.target);
      logger.w(res);
    } catch (e) {
      logger.w(e);
    }
  }

  void updateRecord(String id) async {
    try {
      final res = await TransportServices.changeAddressPost(
          widget.item, id, widget.target);
      Get.back();
    } catch (e) {
      logger.w(e);
    }
  }

  void getListCallTransport() async {
    try {
      var res =
          await TransportServices.listCall(widget.item["_id"], widget.target);
      setState(() {
        listHistoryCall = res;
      });
      getDetail();
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

  void CreateRefund() async {
    try {
      var res = await TransportServices.postRefund(
          target: widget.target,
          reason: _reasonController.text,
          receiveInfor: refund == false ? widget.item['_id'] : "",
          deliveryInfor: refund == true ? widget.item['_id'] : "");
      widget.callback();
    } catch (e) {
      logger.w(e);
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
    getDetail();
    getListCallTransport();
    if (widget.target == 'delivery') {
      setState(() {
        refund = true;
      });
    } else {
      setState(() {
        refund = false;
      });
    }
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: Container(
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Chuyển địa điểm lấy hàng bưu cục",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                      RadioListTile<int>(
                                        title: Text(
                                            'Sô´165, Đường Cầu Giấy, Phường Quan Hoa, Quận Cầu Giấy (ÐT: 02437675246)'),
                                        value: 1,
                                        groupValue: _userController.postIndex,
                                        onChanged: (int? value) {
                                          // handleRadioValueChanged(value);
                                          updateRecord("122000");
                                        },
                                        activeColor: Colors.red,
                                      ),
                                      RadioListTile<int>(
                                        title: Text(
                                            'Sô´8, Phố Hoàng Sâm, Phường Nghĩa Đô, Quận Cầu Giấy (ÐT: 02432123474)'),
                                        value: 2,
                                        groupValue: _userController.postIndex,
                                        onChanged: (int? value) {
                                          // handleRadioValueChanged(value);
                                          updateRecord("122772");
                                        },
                                        activeColor: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Lịch sử cuộc gọi',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              ListView.builder(
                  itemCount: listHistoryCall.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    var data = listHistoryCall[i];
                    return ItemCallWidget(
                      item: data,
                    );
                  }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Xác nhận hoàn hàng?'),
                                content: TextField(
                                  controller: _reasonController,
                                  decoration: InputDecoration(
                                    labelText: 'Lý do hoàn hàng',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CreateRefund();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Hoàn hàng',
                      style: TextStyle(color: Colors.white),
                    ),
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
