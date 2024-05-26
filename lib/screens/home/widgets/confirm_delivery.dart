import 'package:app_transport/components/contact_order.dart';
import 'package:app_transport/services/transport_services.dart';
import 'package:flutter/material.dart';

class ConfirmDeliveryWidget extends StatefulWidget {
  const ConfirmDeliveryWidget({super.key});

  @override
  State<ConfirmDeliveryWidget> createState() => _ConfirmDeliveryWidgetState();
}

class _ConfirmDeliveryWidgetState extends State<ConfirmDeliveryWidget> {
  List listOrder = [];
  void getList() async {
    try {
      var res = await TransportServices.getListDelivery("0");
      setState(() {
        listOrder = res;
      });
    } catch (e) {
      throw Error();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${listOrder.length ?? 0}" ' đơn hàng',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Row(
                  children: [Text('Lọc'), Icon(Icons.filter_alt)],
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Tắt tính năng cuộn
            children: List.generate(
                listOrder.length,
                (index) => ContactOrderWidget(
                      item: listOrder[index],
                      checkStatus: false,
                      callback: getList,
                      target: "delivery",
                    )),
          ),
        ],
      ),
    );
  }
}
