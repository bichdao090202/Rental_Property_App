import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/widgets/card/booking_request_card_from_landlord.dart';
import 'package:rental_property_app/widgets/home/file_picker.dart';
import 'package:rental_property_app/widgets/manager_rentals/contract_tab_from_landlord.dart';

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
              ListView.builder(
                itemCount: bookingRequests.length,
                itemBuilder: (context, index) {
                  final request = bookingRequests[index];
                  return BookingRequestCardFromLandlord(request: request);
                },
              ),
            // SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         Container(
            //             width: double.maxFinite,
            //             child:
            //             ListView.builder(
            //                 shrinkWrap: true,
            //                 itemCount: bookingRequests.length,
            //                 itemBuilder: (context, index) {
            //                   final request = bookingRequests[index];
            //                   return BookingRequestCardFromLandlord(request: request);
            //                 }
            //             )
            //         )
            //       ],
            //     )
            // ),
              const SingleFilepickerScreen(),
              ContractTabFromLandlord(),
            ],
          ),
        ),
      ],
    );
  }
}