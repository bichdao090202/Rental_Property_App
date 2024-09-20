import 'package:rental_property_app/models/address.dart';
import 'package:rental_property_app/models/chargeable_service.dart';
import 'package:rental_property_app/models/utility.dart';

class Property {
  final int id;
  final String title;
  final String image;
  final int ownerId;
  Address? address;
  List<Utility>? utilities;
  final double price;
  final double deposit;
  final int gender;
  final int roomSize;
  final String description;
  String? termOfService;
  final String type;
  List<ChargeableService> chargeableServices;

  Property({
    required this.id,
    required this.title,
    required this.image,
    required this.ownerId,
    this.address,
    this.utilities,
    required this.price,
    required this.deposit,
    required this.gender,
    required this.roomSize,
    required this.description,
    this.termOfService,
    required this.type,
    required this.chargeableServices
  });

  Property.withDefaultAddressAndUtilities({
    required this.id,
    required this.title,
    required this.image,
    required this.ownerId,
    Address? address,
    List<Utility>? utilities,
    required this.price,
    required this.deposit,
    required this.gender,
    required this.roomSize,
    required this.description,
    String? termOfService,
    required this.type,
    required this.chargeableServices,
  })  : this.address = address ?? Address(id: 0, city: "TP.HCM", district: "Gò Vấp", ward: "Phường 1", detail: "Địa chỉ mặc định"),
        this.utilities = utilities ?? [Utility(id: 1, name: "Internet miễn phí")],
        this.termOfService = termOfService ?? "Không có điều khoản dịch vụ";

  String getChargeableServiceString() {
    return chargeableServices.map((service) => '- ${service.getService()}').join('\n');
  }

  // factory Property.fromJson(Map<String, dynamic> json) {
  //   return Property(
  //     id: json['id'],
  //     title: json['title'],
  //     image: json['image'],
  //     ownerId: json['ownerId'],
  //     address: json['address'] != null ? Address.fromJson(json['address']) : null,
  //     utilities: json['utilities'] != null
  //         ? (json['utilities'] as List).map((utility) => Utility.fromJson(utility)).toList()
  //         : null,
  //     price: json['price'],
  //     deposit: json['deposit'],
  //     gender: json['gender'],
  //     roomSize: json['roomSize'],
  //     description: json['description'],
  //     termOfService: json['termOfService'],
  //     type: json['type'],
  //   );
  // }




}
