import 'package:app_transport/screens/home/widgets/refund_delivery.dart';
import 'package:app_transport/screens/home/widgets/refund_receive.dart';
import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RefundTransportWidget extends StatefulWidget {
  const RefundTransportWidget({super.key});

  @override
  State<RefundTransportWidget> createState() => _RefundTransportWidgetState();
}

class _RefundTransportWidgetState extends State<RefundTransportWidget> {
  TabBar get _tabBar => TabBar(
        indicatorColor: ColorsConstants.backgroundMain,
        labelColor: ColorsConstants.backgroundMain,
        tabs: const <Widget>[
          Tab(
            text: 'Giao hàng',
          ),
          Tab(
            text: 'Nhận hàng',
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsConstants.backgroundMain,
            centerTitle: true,
            title: const Text(
              'Danh sách hoàn hàng',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
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
          body: const TabBarView(
            children: <Widget>[
              RefundDeliveryWidget(),
              RefundReceiveWidget(),
            ],
          ),
        ));
  }
}
