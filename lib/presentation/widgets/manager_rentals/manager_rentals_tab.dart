import 'package:flutter/material.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/lessor_tab.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/renter_tab.dart';

import 'package:provider/provider.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
import 'package:rental_property_app/presentation/widgets/auth/login_screen.dart';


class ManagerRentalsTab extends StatefulWidget {
  @override
  _ManagerRentalsTabState createState() => _ManagerRentalsTabState();

}

class _ManagerRentalsTabState extends State<ManagerRentalsTab> {

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(
        builder: (context, authProvider, child)
    {
      final user = authProvider.userInfo;
      if (user == null) {
        return LoginScreen();
      }

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
                RenterTab(userId: user.id),
                LessorTab(userId: user.id),
              ],
            ),
          ),
        ),
      );
    });
  }
}