class Address {
  final int id;
  final String detail, wardName, districtName, provinceName;

  Address({required this.id, this.detail = '', this.wardName = '', this.districtName = '', this.provinceName = ''});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      detail: json['detail'] ?? '',
      wardName: json['ward_name'] ?? '',
      districtName: json['district_name'] ?? '',
      provinceName: json['province_name'] ?? '',
    );
  }
}

class UserInfo {
  final int id;
  final String fullName, email, imgUrl, phone, role;
  final Address address;
  final int balance;

  UserInfo({
    required this.id,
    this.fullName = '',
    this.email = '',
    this.imgUrl = '',
    required this.phone,
    required this.role,
    required this.address,
    this.balance = 0,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      imgUrl: json['img_url'] ?? '',
      phone: json['phone'],
      role: json['role'],
      address: Address.fromJson(json['address'] ?? {}),
      balance: json['balance'] ?? 0,
    );
  }
}

class AuthResponse {
  final String accessToken;
  final UserInfo userInfo;

  AuthResponse({required this.accessToken, required this.userInfo});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['data']['access_token'],
      userInfo: UserInfo.fromJson(json['data']['user_info']),
    );
  }
}
