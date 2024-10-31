import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/presentation/providers/manager_contract_provider.dart';
import 'package:rental_property_app/presentation/widgets/card/booking_request_card.dart';
import 'package:rental_property_app/presentation/widgets/home/file_picker.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/contract_tab_from_landlord.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManagerContractProvider>(context, listen: false)
          .getListBookingRequestByLessorId(3);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingRequestProvider = Provider.of<ManagerContractProvider>(context);

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
              bookingRequestProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: bookingRequestProvider.bookingRequests.length,
                itemBuilder: (context, index) {
                  final bookingRequest = bookingRequestProvider.bookingRequests[index];
                  return BookingRequestCard(request: bookingRequest, type: 'lessor');
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