import 'package:rental_property_app/common/format-data.dart';

class Service {
  final int id;
  final String name;
  final double price;
  final String description;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });


  //
  String getService() {
    return '$name (${formatCurrency(price)}đ/$description)';
  }

factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}