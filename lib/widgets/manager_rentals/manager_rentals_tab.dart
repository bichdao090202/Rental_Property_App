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
            title: const Text('Quản lý', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF1C3988),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: TabBar(
                  labelColor: Colors.white, // Màu chữ của Tab đang được chọn
                  unselectedLabelColor: Colors.white, // Màu chữ của Tab không được chọn
                  labelStyle: TextStyle(
                    fontSize: 16, // Kích thước chữ của Tab đang được chọn
                    fontWeight: FontWeight.bold, // Chữ đậm
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14, // Kích thước chữ của Tab không được chọn
                    fontWeight: FontWeight.normal, // Chữ thường
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