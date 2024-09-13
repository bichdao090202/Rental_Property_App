import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/widgets/manager_rentals/booking_request_card_from_landlord.dart';
import 'package:rental_property_app/widgets/manager_rentals/booking_request_card_from_renter.dart';


class LandlordTab extends StatefulWidget {
  const LandlordTab({super.key});


  @override
  _LandlordTabState createState() => _LandlordTabState();

}

class _LandlordTabState extends State<LandlordTab> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Yêu cầu thuê'),
            Tab(text: 'Bài đăng'),
            Tab(text: 'Hợp đồng'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
            SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: double.maxFinite,
                        child:
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: bookingRequests.length,
                            itemBuilder: (context, index) {
                              final request = bookingRequests[index];
                              return BookingRequestCardFromLandlord(request: request);
                            }
                        )
                    )
                  ],
                )
            ),
              Card(
                margin: EdgeInsets.all(16.0),
                child: Center(child: Text('Bài đăng')),
              ),
              Card(
                margin: EdgeInsets.all(16.0),
                child: Center(child: Text('Hợp đồng')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}