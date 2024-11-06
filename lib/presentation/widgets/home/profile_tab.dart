
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
import 'package:rental_property_app/presentation/widgets/auth/login_screen.dart';

// class ProfileTab extends StatefulWidget {
//   @override
//   _ProfileTabState createState() => _ProfileTabState();
//
// }
//
// class _ProfileTabState extends State<ProfileTab> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
//
// }


class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.userInfo;
        if (user == null) {
          // return Center(child: CircularProgressIndicator());
          return LoginScreen();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      // user.imgUrl.isNotEmpty
                      //     ? NetworkImage(user.imgUrl)
                      //     :
                      // AssetImage('assets/default_avatar.png') as ImageProvider,
                      NetworkImage('https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='),
                    ),
                    SizedBox(height: 16),
                    Text(
                      user.fullName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.getPhoneNumber(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Thông tin chi tiết
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.email,
                      title: 'Email',
                      subtitle: user.getEmail(),
                    ),
                    _buildInfoTile(
                      icon: Icons.account_balance_wallet,
                      title: 'Số dư',
                      subtitle: NumberFormat.currency(
                        locale: 'vi_VN',
                        symbol: 'đ',
                      ).format(user.balance),
                    ),
                    if (user.address != null)
                      _buildInfoTile(
                        icon: Icons.location_on,
                        title: 'Địa chỉ',
                        subtitle: '${user.address!.detail}, ${user.address!.wardName}, ${user.address!.districtName}, ${user.address!.provinceName}',
                      ),

                    // Các nút tác vụ
                    SizedBox(height: 24),
                    _buildActionButton(
                      context,
                      'Chỉnh sửa thông tin',
                      Icons.edit,
                          () {
                        // TODO: Navigate to edit profile
                      },
                    ),
                    _buildActionButton(
                      context,
                      'Đổi mật khẩu',
                      Icons.lock,
                          () {
                        // TODO: Navigate to change password
                      },
                    ),
                    _buildActionButton(
                      context,
                      'Đăng xuất',
                      Icons.logout,
                          () async {
                        await authProvider.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onPressed,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          minimumSize: Size(double.infinity, 0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}