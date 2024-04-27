import 'package:app_transport/shared/constant/color_constant.dart';
import 'package:flutter/material.dart';

class ReceiveBodyWidget extends StatefulWidget {
  const ReceiveBodyWidget({super.key});

  @override
  State<ReceiveBodyWidget> createState() => _ReceiveBodyWidgetState();
}

class _ReceiveBodyWidgetState extends State<ReceiveBodyWidget> {
  TabBar get _tabBar => TabBar(
        indicatorColor: ColorsConstants.backgroundMain,
        labelColor: ColorsConstants.backgroundMain,
        tabs: const <Widget>[
          Tab(
            text: 'Chưa nhận',
          ),
          Tab(
            text: 'Bàn giao',
          ),
          Tab(
            text: 'Đã nhận',
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsConstants.backgroundMain,
            centerTitle: true,
            title: const Text(
              'Nhận hàng',
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
              Text('Chưa nhận'),
              Text('Nhận bàn giao'),
              Text('Đã nhận')
            ],
          ),
        ));
  }
}
