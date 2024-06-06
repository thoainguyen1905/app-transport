import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCallWidget extends StatefulWidget {
  ItemCallWidget({super.key, required this.item});
  dynamic item;
  @override
  State<ItemCallWidget> createState() => _ItemCallWidgetState();
}

class _ItemCallWidgetState extends State<ItemCallWidget> {
  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.call),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['phone'] ?? '0987676888',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:
                            widget.item['missing'] ? Colors.red : Colors.black),
                  ),
                  widget.item['missing']
                      ? Text(
                          'missing',
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox()
                ],
              )
            ],
          ),
          Row(
            children: [
              Text(
                formatDate(widget.item['createTime']) ?? '19/05/2000',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.info)
            ],
          )
        ],
      ),
    );
  }
}
