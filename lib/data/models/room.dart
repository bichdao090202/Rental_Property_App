import 'package:rental_property_app/data/models/address.dart';
import 'package:rental_property_app/data/models/borrowed_item.dart';
import 'package:rental_property_app/data/models/service.dart';

class Room {
  final int id;
  final String title;
  final List<String> images;
  Address? address;
  final int ownerId;
  final double price;
  final double deposit;
  final int gender;
  final int acreage;
  final String description;
  String? termOfService;
  List<Service>? services;
  List<BorrowItem>? borrowItems;
  final int? maxPeople;
  final int? roomType;

  Room(
      {required this.id,
      required this.title,
      required this.images,
      required this.ownerId,
      this.address,
      required this.price,
      required this.deposit,
      required this.gender,
      required this.acreage,
      required this.description,
      this.services,
      this.borrowItems,
      this.maxPeople,
      this.roomType});

  Room.withDefaultAddressAndUtilities(
      {required this.id,
      required this.title,
      required this.images,
      required this.ownerId,
      Address? address,
      required this.price,
      required this.deposit,
      required this.gender,
      required this.acreage,
      required this.description,
      required this.services,
      this.borrowItems,
      this.maxPeople,
      this.roomType})
      : this.address = address ??
            Address(
                id: 0,
                provinceName: "TP.HCM",
                districtName: "Gò Vấp",
                wardName: "Phường 1",
                detail: "Địa chỉ mặc định");

  String getChargeableServiceString() {
    return services?.map((service) => service.getService()).join(', ') ??
        'Không có dịch vụ phụ thu';
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      images: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? (json['images'] as List).map((item) {
              return item.toString();
            }).toList()
          : [],
      ownerId: json['owner_id'] ?? 0,
      address: Address.fromJson(json['address']),
      price: json['price'] ?? 0.0,
      deposit: json['deposit'] ?? 0.0,
      gender: json['gender'] ?? 0,
      acreage: json['acreage'] ?? 0,
      description: json['description'] ?? '',
      maxPeople: json['max_people'] ?? 0,
      roomType: json['room_type'] ?? 0,
      borrowItems: json['borrowed_items'] != null
          ? (json['borrowed_items'] as List)
              .map((item) => BorrowItem.fromJson(item))
              .toList()
          : [],
      services: json['services'] != null
          ? (json['services'] as List)
              .map((item) => Service.fromJson(item))
              .toList()
          : [],
    );
  }
}
