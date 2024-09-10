// import 'package:flutter/material.dart';
//
// class LandlordTab extends StatefulWidget {
//   @override
//   _LandlordTabState createState() => _LandlordTabState();
//
// }
//
// class _LandlordTabState extends State<LandlordTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: const TabBar(
//               tabs: [
//                 Tab(text: "Bài đăng"),
//                 Tab(text: "Yêu cầu thuê")
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               Text('Landlord Tab'),
//               Text('Tab Danh sách tài sản, Tab danh sách yêu cầu thuê'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   return DefaultTabController(
//   //     length: 2,
//   //     child: Scaffold(
//   //       appBar: PreferredSize(
//   //         preferredSize: Size.fromHeight(35),
//   //         child: AppBar(
//   //           bottom: TabBar(
//   //             tabs: <Widget>[
//   //               Text('Tab 1'),
//   //               Text('Tab 2'),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       body: TabBarView(
//   //         children: [
//   //           Text('Landlord Tab'),
//   //           Text('Tab Danh sách tài sản, Tab danh sách yêu cầu thuê'),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }

import 'package:flutter/material.dart';

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
            Tab(text: 'Bài đăng'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              Card(
                margin: EdgeInsets.all(16.0),
                child: Center(
                    child: Text('Yêu cầu thuê')),
              ),
              Card(
                margin: EdgeInsets.all(16.0),
                child: Center(child: Text('Bài đăng')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}