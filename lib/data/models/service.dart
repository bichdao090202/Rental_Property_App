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


  String getService() {
    return '$name (${formatCurrency(price)}đ/$description)';
  }

// factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       description: json['description'],
//     );
//   }


  factory Service.fromJson(Map<String, dynamic> json) {
    try {

      // Parse các trường với careful type casting và null check
      int idValue = 0;
      if (json['id'] != null) {
        idValue = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0;
      }

      String nameValue = json['name']?.toString() ?? 'Unknown Service';

      double priceValue = 0.0;
      if (json['price'] != null) {
        priceValue = json['price'] is int
            ? (json['price'] as int).toDouble()
            : (json['price'] as num).toDouble();
      }

      String descriptionValue = json['description']?.toString() ?? 'No description';

      return Service(
        id: idValue,
        name: nameValue,
        price: priceValue,
        description: descriptionValue,
      );
    } catch (e) {
      print('Error parsing Service: $e');
      // Return a Service with default values in case of an error
      return Service(
        id: 0,
        name: 'Default Service',
        price: 0.0,
        description: 'Default description',
      );
    }
  }
}