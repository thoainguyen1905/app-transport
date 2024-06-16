import 'package:app_transport/components/refund_item.dart';
import 'package:app_transport/services/transport_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:flutter/material.dart';

class RefundReceiveWidget extends StatefulWidget {
  const RefundReceiveWidget({super.key});

  @override
  State<RefundReceiveWidget> createState() => _RefundReceiveWidgetState();
}

class _RefundReceiveWidgetState extends State<RefundReceiveWidget> {
  List listOrder = [];
  void getList() async {
    try {
      var res = await TransportServices.getListRefund(target: 'receive');
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
              var delivery = item['receiveInfor'];
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
