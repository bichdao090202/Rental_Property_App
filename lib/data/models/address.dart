class Address {
  final int id;
  final String provinceName;
  final String districtName;
  final String wardName;
  final String detail;

  Address({
    required this.id,
    required this.provinceName,
    required this.districtName,
    required this.wardName,
    required this.detail,
  });

  String getShortAddress() {
    return '$provinceName, $districtName, $wardName';
  }

  String getAddressDetail() {
    return '$detail, $wardName, $districtName, $provinceName';
  }

  // factory Address.fromJson(Map<String, dynamic> json) {
  //   if (json.isEmpty) {
  //     return Address(
  //       id: 0,
  //       provinceName: 'TP.HCM',
  //       districtName: 'Gò Vấp',
  //       wardName: 'Phường 1',
  //       detail: 'Địa chỉ mặc định',
  //     );
  //   }
  //   return Address(
  //     id: json['id']??0,
  //     provinceName: json['province_name']??'',
  //     districtName: json['district_name']??'',
  //     wardName: json['ward_name']??'',
  //     detail: json['detail']??'',
  //   );
  // }
  factory Address.fromJson(Map<String, dynamic> json) {
    try {
      // Nếu json rỗng hoặc null, trả về địa chỉ mặc định
      if (json == null || json.isEmpty) {
        return Address(
          id: 0,
          provinceName: 'TP.HCM',
          districtName: 'Gò Vấp',
          wardName: 'Phường 1',
          detail: 'Địa chỉ mặc định',
        );
      }

      return Address(
        id: json['id'] ?? 0,
        provinceName: json['province_name']?.toString() ?? '',
        districtName: json['district_name']?.toString() ?? '',
        wardName: json['ward_name']?.toString() ?? '',
        detail: json['detail']?.toString() ?? '',
      );
    } catch (e) {
      print('Error parsing Address: $e');
      return Address(
        id: 0,
        provinceName: 'TP.HCM',
        districtName: 'Gò Vấp',
        wardName: 'Phường 1',
        detail: 'Địa chỉ mặc định',
      );
    }
  }
}

