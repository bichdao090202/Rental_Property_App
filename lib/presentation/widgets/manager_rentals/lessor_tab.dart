import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/presentation/providers/manager_contract_provider.dart';
import 'package:rental_property_app/presentation/widgets/card/booking_request_card.dart';
import 'package:rental_property_app/presentation/widgets/home/file_picker.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/booking_requests_tab.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/contract_tab_from_landlord.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/contracts_tab.dart';

class LessorTab extends StatefulWidget {
  final int userId;
  const LessorTab({super.key, required this.userId});

  @override
  _LessorTabState createState() => _LessorTabState();

}

class _LessorTabState extends State<LessorTab> with TickerProviderStateMixin {
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
              BookingRequestsTab(userId: widget.userId, type: 'lessor'),
              ContractsTab(userId: widget.userId, type: 'lessor'),
              ContractsTab(userId: widget.userId, type: 'lessor'),
            ],
          ),
        ),
      ],
    );
  }
}