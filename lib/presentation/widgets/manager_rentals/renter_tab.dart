import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/presentation/providers/manager_contract_provider.dart';
import 'package:rental_property_app/presentation/widgets/card/booking_request_card.dart';
import 'package:rental_property_app/presentation/widgets/card/contract_card.dart';

class RenterTab extends StatefulWidget {
  const RenterTab({super.key});

  @override
  _RenterTabState createState() => _RenterTabState();

}

class _RenterTabState extends State<RenterTab> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManagerContractProvider>(context, listen: false)
          .getListBookingRequestByRenterId(4);
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
            Tab(text: 'Hợp đồng')
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // ListView.builder(
              //     itemCount: bookingRequests.length,
              //     itemBuilder: (context, index) {
              //       final request = bookingRequests[index];
              //       return BookingRequestCardFromRenter(request: request, type: 'renter');
              //     }
              // ),

              bookingRequestProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: bookingRequestProvider.bookingRequests.length,
                itemBuilder: (context, index) {
                  final bookingRequest = bookingRequestProvider.bookingRequests[index];
                  return BookingRequestCard(request: bookingRequest, type: 'renter');
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
              //                   return BookingRequestCardFromRenter(request: request);
              //                 }
              //             )
              //         )
              //       ],
              //     )
              // ),
              ListView.builder(
                  itemCount: contracts.where((contract) => contract.renterId != null).length,
                  itemBuilder: (context, index) {
                    final contract = contracts.where((contract) => contract.renterId != null).elementAt(index);
                    return ContractCard(contract: contract, type: "renter",);
                  }
              ),
              // SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         Container(
              //             width: double.maxFinite,
              //             child:
              //             ListView.builder(
              //                 shrinkWrap: true,
              //                 itemCount: contracts.where((contract) => contract.renterId != null).length,
              //                 itemBuilder: (context, index) {
              //                   final contract = contracts.where((contract) => contract.renterId != null).elementAt(index);
              //                   return ContractCardFromRenter(contract: contract);
              //                 }
              //             )
              //         )
              //       ],
              //     )
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
// Text('Combo box: Chấp nhận, từ chối, đang chờ'),
// Text('Danh sách các yêu cầu thuê'),