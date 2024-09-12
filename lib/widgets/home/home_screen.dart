import 'package:flutter/material.dart';
import 'package:rental_property_app/widgets/home/filter_modal.dart';
import 'package:rental_property_app/widgets/home/home_tab.dart';
import 'package:rental_property_app/widgets/manager_rentals/manager_rentals_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0; //

  final List<Widget> _pages = [

    Center(child: ManagerRentalsTab()), //
    Center(child: HomeTab()), //
    Center(child: FilterModal()), //
    Center(child: Text('Notice Page')), //
    Center(child: Text('Profile Page')), //
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiêm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Quản lý',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat_bubble),
          //   label: 'Message',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Notice',
          //
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF1C3988),
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}