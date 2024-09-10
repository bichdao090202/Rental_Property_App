import 'package:flutter/material.dart';
import 'package:rental_property_app/widgets/manager_rentals/landlord_tab.dart';
import 'package:rental_property_app/widgets/manager_rentals/renter_tab.dart';

class ManagerRentalsTab extends StatefulWidget {
  @override
  _ManagerRentalsTabState createState() => _ManagerRentalsTabState();

}

class _ManagerRentalsTabState extends State<ManagerRentalsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quản lý'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.key),
                  text: "Thuê",

                ),
                Tab(
                  icon: Icon(Icons.home_work),
                  text: "Cho thuê",
                )
              ],
            ),
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