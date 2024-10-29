class Address {
  final int id;
  final String city;
  final String district;
  final String ward;
  final String detail;

  Address({
    required this.id,
    required this.city,
    required this.district,
    required this.ward,
    required this.detail,
  });

  String getShortAddress() {
    return '$city, $district, $ward';
  }

  String getAddressDetail() {
    return '$detail, $ward, $district, $city';
  }
}
