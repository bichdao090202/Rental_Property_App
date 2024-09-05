import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0; //

  final List<Widget> _pages = [
    Center(child: Text('Home Page')), //
    Center(child: Text('Search Page')), //
    Center(child: Text('Message')), //
    Center(child: Text('Notifications Page')), //
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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