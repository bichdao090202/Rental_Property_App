import 'package:rental_property_app/data/models/address.dart';

class User {
  int id;
  String fullName;
  String? email;
  String? phone;
  String? imgUrl;
  Address? address;
  double balance;
  String? accessToken;
  String? identityNumber;

  User({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.imgUrl,
    this.address,
    required this.balance,
    this.accessToken,
    this.identityNumber
  });

  void updateProfile({
    String? newName,
    String? newEmail,
    String? newPhoneNumber,
    String? newProfileImage,
  }) {
    if (newName != null) {
      this.fullName = newName;
    }
    if (newEmail != null) {
      this.email = newEmail;
    }
    if (newPhoneNumber != null) {
      this.phone = newPhoneNumber;
    }
    if (newProfileImage != null) {
      this.imgUrl = newProfileImage;
    }
  }

  String getPhoneNumber() {
    return phone ?? 'Chưa cập nhật';
  }

  String getEmail() {
    return email ?? 'Chưa cập nhật';
  }

  String displayUserInfo() {
    return ('User ID: $id Name: $fullName');
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      imgUrl: json['img_url'],
      phone: json['phone'],
      identityNumber: json['identity_number'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      balance: (json['balance'] as num).toDouble(),
    );
  }
}