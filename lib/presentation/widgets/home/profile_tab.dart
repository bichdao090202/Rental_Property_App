
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
import 'package:rental_property_app/presentation/widgets/auth/login_screen.dart';
import 'package:rental_property_app/presentation/widgets/user/user_account_screen.dart';
import 'package:rental_property_app/presentation/widgets/user/user_digital_signature_screen.dart';
import 'package:rental_property_app/presentation/widgets/user/user_info_screen.dart';
import 'package:rental_property_app/presentation/widgets/user/user_transaction_screen.dart';

class ProfileTab extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Thông tin',
      'key': '/user/info',
      'icon': Icons.supervised_user_circle,
    },
    {
      'title': 'Tài khoản',
      'key': '/user/account',
      'icon': Icons.manage_accounts,
    },
    {
      'title': 'Giao dịch',
      'key': '/user/transaction',
      'icon': Icons.paid,
    },
    {
      'title': 'Chữ ký số',
      'key': '/user/digital-signature',
      'icon': Icons.draw,
    },
    {
      'title': 'Đăng xuất',
      'key': '/log-out',
      'icon': Icons.logout,
    },
  ];

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 60, color: Theme
                            .of(context)
                            .primaryColor),
                      ),
                      SizedBox(height: 12),
                      const Text(
                        'Quản lý tài khoản',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: items.map((item) =>
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(item['icon'], color: Theme
                                .of(context)
                                .primaryColor),
                          ),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () async {
                            switch (item['key']) {
                              case '/user/info':
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => UserInfoScreen()));
                                break;
                              case '/user/account':
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => UserAccountScreen()));
                                break;
                              case '/user/transaction':
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => UserTransactionScreen()));
                                break;
                              case '/user/digital-signature':
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => DigitalSignatureScreen()));
                                break;
                              case '/log-out':
                                final authProvider = Provider.of<AuthProvider>(
                                    context, listen: false);
                                await authProvider.logout();
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                                break;
                            }
                          },
                        ),
                      )).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: 40),
  //           Text(
  //             'Cài đặt',
  //             style: TextStyle(
  //               fontSize: 32,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 32),
  //           ...items.map((item) =>
  //               Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       switch (item['key']) {
  //                         case '/user/info':
  //                           Navigator.push(context, MaterialPageRoute(
  //                               builder: (_) => UserInfoScreen()));
  //                           break;
  //                         case '/user/account':
  //                           Navigator.push(context, MaterialPageRoute(
  //                               builder: (_) => UserAccountScreen()));
  //                           break;
  //                         case '/user/transaction':
  //                           Navigator.push(context, MaterialPageRoute(
  //                               builder: (_) => UserTransactionScreen()));
  //                           break;
  //                       }
  //                     },
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(vertical: 16),
  //                       child: Row(
  //                         children: [
  //                           Icon(item['icon'], size: 24),
  //                           SizedBox(width: 16),
  //                           Text(
  //                             item['title'],
  //                             style: TextStyle(fontSize: 18),
  //                           ),
  //                           Spacer(),
  //                           Icon(Icons.arrow_forward_ios, size: 16),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(),
  //                 ],
  //               )).toList(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
