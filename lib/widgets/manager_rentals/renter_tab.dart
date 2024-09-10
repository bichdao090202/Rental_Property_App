import 'package:flutter/material.dart';

class RenterTab extends StatefulWidget {
  @override
  _RenterTabState createState() => _RenterTabState();

}

class _RenterTabState extends State<RenterTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Text('Renter Tab'),
          Text('Combo box: Chấp nhận, từ chối, đang chờ'),
          Text('Danh sách các yêu cầu thuê'),
          Text('Status: Đang chờ chủ trọ đồng ý, Đang chờ khách hàng ký và thanh toán, Đang có hiệu lực, Hết hạn, Chủ nhà từ chối, Khách hàng hủy'),
        ],
      ),
    );
  }
}