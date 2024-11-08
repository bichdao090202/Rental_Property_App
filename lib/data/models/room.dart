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

  // factory Room.fromJson(Map<String, dynamic> json) {
  //   return Room(
  //     id: json['id'] ?? 0,
  //     title: json['title'] ?? '',
  //     images: (json['images'] != null && (json['images'] as List).isNotEmpty)
  //         ? (json['images'] as List).map((item) {
  //             return item.toString();
  //           }).toList()
  //         : [],
  //     ownerId: json['owner_id'] ?? 0,
  //     address: Address.fromJson(json['address']),
  //     price: json['price'] ?? 0.0,
  //     deposit: json['deposit'] ?? 0.0,
  //     gender: json['gender'] ?? 0,
  //     acreage: json['acreage'] ?? 0,
  //     description: json['description'] ?? '',
  //     maxPeople: json['max_people'] ?? 0,
  //     roomType: json['room_type'] ?? 0,
  //     borrowItems: json['borrowed_items'] != null
  //         ? (json['borrowed_items'] as List)
  //             .map((item) => BorrowItem.fromJson(item))
  //             .toList()
  //         : [],
  //     services: json['services'] != null
  //         ? (json['services'] as List)
  //             .map((item) => Service.fromJson(item))
  //             .toList()
  //         : [],
  //   );
  // }

  factory Room.fromJson(Map<String, dynamic> json) {
    try {
      // Kiểm tra json có null hay không
      if (json == null) {
        throw Exception('JSON data is null');
      }

      // Parse images với null check
      List<String> imagesList = [];
      if (json['images'] != null) {
        if (json['images'] is List) {
          imagesList =
              (json['images'] as List).map((item) => item.toString()).toList();
        }
      }

      // Parse borrowed items với null check
      List<BorrowItem> borrowedItems = [];
      if (json['borrowed_items'] != null) {
        if (json['borrowed_items'] is List) {
          borrowedItems = (json['borrowed_items'] as List)
              .map((item) => BorrowItem.fromJson(item))
              .toList();
        }
      }

      // Parse services với null check
      List<Service> servicesList = [];
      if (json['services'] != null) {
        if (json['services'] is List) {
          servicesList = (json['services'] as List)
              .map((item) => Service.fromJson(item))
              .toList();
        }
      }

      // Parse address với null safety
      Address roomAddress = Address.fromJson(json['address'] ?? {});

      // Parse các trường số với careful type casting
      double priceValue = 0.0;
      if (json['price'] != null) {
        priceValue = (json['price'] is int)
            ? (json['price'] as int).toDouble()
            : (json['price'] as num).toDouble();
      }

      double depositValue = 0.0;
      if (json['deposit'] != null) {
        depositValue = (json['deposit'] is int)
            ? (json['deposit'] as int).toDouble()
            : (json['deposit'] as num).toDouble();
      }

      return Room(
        id: json['id'] ?? 0,
        title: json['title']?.toString() ?? '',
        images: imagesList,
        ownerId: json['owner_id'] ?? 0,
        address: roomAddress,
        price: priceValue,
        deposit: depositValue,
        gender: json['gender'] ?? 0,
        acreage: json['acreage'] ?? 0,
        description: json['description']?.toString() ?? '',
        maxPeople: json['max_people'] ?? 0,
        roomType: json['room_type'] ?? 0,
        borrowItems: borrowedItems,
        services: servicesList,
      );
    } catch (e) {
      print('Error parsing Room: $e');
      // Return một Room với giá trị mặc định trong trường hợp lỗi
      return Room(
        id: 0,
        title: '',
        images: [],
        ownerId: 0,
        address: Address(
          id: 0,
          provinceName: 'TP.HCM',
          districtName: 'Gò Vấp',
          wardName: 'Phường 1',
          detail: 'Địa chỉ mặc định',
        ),
        price: 0.0,
        deposit: 0.0,
        gender: 0,
        acreage: 0,
        description: '',
        maxPeople: 0,
        roomType: 0,
        borrowItems: [],
        services: [],
      );
    }
  }
}
