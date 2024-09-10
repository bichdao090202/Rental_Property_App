import 'package:rental_property_app/models/address.dart';
import 'package:rental_property_app/models/utility.dart';

class Property {
  int id;
  String title;
  String image;
  int ownerId;
  Address? address;
  List<Utility>? utilities;
  double? price;

  Property({
    required this.id,
    required this.title,
    required this.image,
    required this.ownerId,
    required this.address,
    required this.utilities,
    required this.price
  });


}