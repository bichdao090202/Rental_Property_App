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
      Provider.of<ManagerContractProvider>(context, listen: false)
          .getContractByRenterId(4);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final managerProvider = Provider.of<ManagerContractProvider>(context);

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
              managerProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: managerProvider.bookingRequests.length,
                itemBuilder: (context, index) {
                  final bookingRequest = managerProvider.bookingRequests[index];
                  return BookingRequestCard(request: bookingRequest, type: 'renter');
                },
              ),
              // ListView.builder(
              //     itemCount: contracts.where((contract) => contract.renter.id != null).length,
              //     itemBuilder: (context, index) {
              //       final contract = contracts.where((contract) => contract.renter.id != null).elementAt(index);
              //       return ContractCard(contract: contract, type: "renter",);
              //     }
              // ),

              managerProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: managerProvider.contracts.length,
                itemBuilder: (context, index) {
                  final contract = managerProvider.contracts[index];
                  return ContractCard(contract: contract, type: "renter",);
                },
              ),


            ],
          ),
        ),
      ],
    );
  }
}
// Text('Combo box: Chấp nhận, từ chối, đang chờ'),
// Text('Danh sách các yêu cầu thuê'),