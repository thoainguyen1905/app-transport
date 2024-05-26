import 'package:app_transport/screens/home/widgets/confirm_delivery.dart';
import 'package:app_transport/screens/home/widgets/persistent_transport.dart';
import 'package:app_transport/screens/home/widgets/receive_transport.dart';
import 'package:app_transport/screens/home/widgets/total_delivery.dart';
import 'package:app_transport/screens/home/widgets/total_transport.dart';
import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';

class DetailsOrderWidget extends StatefulWidget {
  const DetailsOrderWidget({super.key});

  @override
  State<DetailsOrderWidget> createState() => _DetailsOrderWidgetState();
}

class _DetailsOrderWidgetState extends State<DetailsOrderWidget> {
  TabBar get _tabBar => TabBar(
        indicatorColor: ColorsConstants.backgroundMain,
        labelColor: ColorsConstants.backgroundMain,
        tabs: const <Widget>[
          Tab(
            text: 'Xác nhận giao',
          ),
          Tab(
            text: 'Tổng giao',
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsConstants.backgroundMain,
            centerTitle: true,
            title: const Text(
              'Giao hàng',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              ConfirmDeliveryWidget(),
              TotalDeliveryWidget(),
            ],
          ),
        ));
  }
}
