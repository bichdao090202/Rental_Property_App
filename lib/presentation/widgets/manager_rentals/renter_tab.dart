// class _RenterTabState extends State<RenterTab> with TickerProviderStateMixin {
//   late final TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ManagerContractProvider>(context, listen: false)
//           .getListBookingRequestByRenterId(widget.userId);
//       Provider.of<ManagerContractProvider>(context, listen: false)
//           .getContractByRenterId(widget.userId);
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final managerProvider = Provider.of<ManagerContractProvider>(context);
//
//     return Column(
//       children: <Widget>[
//         TabBar.secondary(
//           controller: _tabController,
//           tabs: const <Widget>[
//             Tab(text: 'Yêu cầu thuê'),
//             Tab(text: 'Hợp đồng')
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: <Widget>[
//               managerProvider.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : managerProvider.bookingRequests.isEmpty
//                   ? const Center(child: Text('Không có yêu cầu thuê nào'))
//                   : ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: managerProvider.bookingRequests.length,
//                 itemBuilder: (context, index) {
//                   final bookingRequest = managerProvider.bookingRequests[index];
//                   return BookingRequestCard(request: bookingRequest, type: 'renter');
//                 },
//               ),
//               managerProvider.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: managerProvider.contracts.length,
//                 itemBuilder: (context, index) {
//                   final contract = managerProvider.contracts[index];
//                   return ContractCard(contract: contract, type: "renter",);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/booking_requests_tab.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/contracts_tab.dart';

class RenterTab extends StatefulWidget {
  final int userId;
  const RenterTab({super.key, required this.userId});

  @override
  _RenterTabState createState() => _RenterTabState();
}

class _RenterTabState extends State<RenterTab> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            Tab(text: 'Hợp đồng')
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              BookingRequestsTab(userId: widget.userId, type: 'renter'),
              ContractsTab(userId: widget.userId, type: 'renter'),
            ],
          ),
        ),
      ],
    );
  }
}