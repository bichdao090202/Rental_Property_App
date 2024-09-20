import 'package:flutter/material.dart';
import 'package:rental_property_app/widgets/manager_rentals/landlord_tab.dart';
import 'package:rental_property_app/widgets/manager_rentals/renter_tab.dart';
import 'dart:convert';

class ManagerRentalsTab extends StatefulWidget {
  @override
  _ManagerRentalsTabState createState() => _ManagerRentalsTabState();

}

class _ManagerRentalsTabState extends State<ManagerRentalsTab> {

  @override
  Widget build(BuildContext context) {
    String originalString = 'Hello';

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quản lý'),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: [
                    Tab(
                      text: "Thuê",
                    ),
                    Tab(
                      text: "Cho thuê",
                    )
                  ],
                ),
            )
          ),
          body: TabBarView(
            children: [
              RenterTab(),
              LandlordTab(),
            ],
          ),
        ),
      ),
    );
  }
}