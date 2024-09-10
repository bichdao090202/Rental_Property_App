import 'package:flutter/material.dart';

class ManagerRentalsTab extends StatefulWidget {
  @override
  _ManagerRentalsTabState createState() => _ManagerRentalsTabState();

}

class _ManagerRentalsTabState extends State<ManagerRentalsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý'),
      ),
      body: Center(
        child: Text('Manager Rentals Tab'),
      ),
    );
  }
}