import 'package:flutter/material.dart';

class LandlordTab extends StatefulWidget {
  @override
  _LandlordTabState createState() => _LandlordTabState();

}

class _LandlordTabState extends State<LandlordTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Landlord Tab'),
        Text('Tab Danh sách tài sản, Tab danh sách yêu cầu thuê'),
      ],
    );
  }
}