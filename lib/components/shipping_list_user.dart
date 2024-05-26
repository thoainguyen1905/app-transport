import 'package:app_transport/controllers/auth_controller.dart';
import 'package:app_transport/services/user_services.dart';
import 'package:app_transport/shared/helper/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingListUser extends StatefulWidget {
  const ShippingListUser({super.key});

  @override
  State<ShippingListUser> createState() => _ShippingListUserState();
}

enum SingingCharacter { lafayette, jefferson }

class _ShippingListUserState extends State<ShippingListUser> {
  final UserController _userController = Get.put(UserController());
  SingingCharacter? _character = SingingCharacter.lafayette;
  void getMe() async {
    try {
      var res = await UserServices.getMe();
      if (res['name'] != '') {
        setState(() {
          _userController.updateInfor(res);
        });
        logger.w(res['post']);
      }
    } catch (e) {
      logger.w(e);
    }
  }

  int _selectedValue = 1;

  void handleRadioValueChanged(int? value) {
    _userController.updatePostIndex(value ?? 1);
    setState(() {
      _selectedValue = value ?? 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Chuyển đổi bưu cục ",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ],
          ),
          RadioListTile<int>(
            title: Text('Bưu cục cấp 2 Cầu Giấy'),
            value: 1,
            groupValue: _userController.postIndex,
            onChanged: (int? value) {
              handleRadioValueChanged(value);
            },
            activeColor: Colors.red,
          ),
          RadioListTile<int>(
            title: Text('Bưu cục cấp 3 Hoàng Sâm'),
            value: 2,
            groupValue: _userController.postIndex,
            onChanged: (int? value) {
              handleRadioValueChanged(value);
            },
            activeColor: Colors.red,
          ),
          // RadioListTile<int>(
          //   title: Text('Option 3'),
          //   value: 3,
          //   groupValue: _selectedValue,
          //   onChanged: (int? value) {
          //     handleRadioValueChanged(value);
          //   },
          //   activeColor: Colors.red, // Đặt màu khi được chọn
          // ),
        ],
      ),
    );
  }
}
