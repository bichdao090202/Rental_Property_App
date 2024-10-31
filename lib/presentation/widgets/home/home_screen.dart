import 'package:flutter/material.dart';
import 'package:rental_property_app/presentation/widgets/home/home_tab.dart';
import 'package:rental_property_app/presentation/widgets/home/profile_tab.dart';
import 'package:rental_property_app/presentation/widgets/manager_rentals/manager_rentals_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0; //

  final List<Widget> _pages = [
    Center(child: HomeTab()), //
    Center(child: ManagerRentalsTab()), //
    // Center(child: FilterModal()), //
    const Center(child: Text('Message Page')), //
    // const Center(child: Text('Profile Page')),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    // FilePickerDialog.show(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => UploadImagePage(imagePath: 'assets/logo.png'),
    //   ),
    // );
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: 'Tìm kiêm',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Tin nhắn',
          ),
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
        selectedItemColor: const Color(0xFF1C3988),
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}