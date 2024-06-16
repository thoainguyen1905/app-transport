import 'package:app_transport/components/contact_order.dart';
import 'package:app_transport/components/refund_item.dart';
import 'package:app_transport/services/transport_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:flutter/material.dart';

class RefundDeliveryWidget extends StatefulWidget {
  const RefundDeliveryWidget({super.key});

  @override
  State<RefundDeliveryWidget> createState() => _RefundDeliveryWidgetState();
}

class _RefundDeliveryWidgetState extends State<RefundDeliveryWidget> {
  List listOrder = [];
  void getList() async {
    try {
      var res = await TransportServices.getListRefund(target: 'delivery');

      setState(() {
        listOrder = res;
      });
    } catch (e) {
      logger.w(e);
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Tắt tính năng cuộn
            children: List.generate(listOrder.length, (index) {
              var item = listOrder[index];
              var delivery = item['deliveryInfor'];
              // logger.w(item);
              return RefundItemWidget(
                item: delivery,
                reason: item['reason'],
              );
            }),
          )
        ],
      ),
    );
  }
}
