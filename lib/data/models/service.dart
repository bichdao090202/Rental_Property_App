// models/room.dart
class Room {
  final int id;
  final String title;
  final Address address;
  final double acreage;
  final double price;
  final String description;
  final String dateSubmitted;
  final int ownerId;
  final int maxPeople;
  final int roomType;
  final double deposit;
  final List<Service> services;
  final List<String> images;

  Room({
    required this.id,
    required this.title,
    required this.address,
    required this.acreage,
    required this.price,
    required this.description,
    required this.dateSubmitted,
    required this.ownerId,
    required this.maxPeople,
    required this.roomType,
    required this.deposit,
    required this.services,
    required this.images,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      title: json['title'],
      address: Address.fromJson(json['address']),
      acreage: json['acreage'].toDouble(),
      price: json['price'].toDouble(),
      description: json['description'],
      dateSubmitted: json['date_submitted'],
      ownerId: json['owner_id'],
      maxPeople: json['max_people'],
      roomType: json['room_type'],
      deposit: json['deposit'].toDouble(),
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
      images: List<String>.from(json['images']),
    );
  }
}

class Address {
  final int id;
  final String detail;
  final String wardName;
  final String districtName;
  final String provinceName;

  Address({
    required this.id,
    required this.detail,
    required this.wardName,
    required this.districtName,
    required this.provinceName,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      detail: json['detail'],
      wardName: json['ward_name'],
      districtName: json['district_name'],
      provinceName: json['province_name'],
    );
  }
}

class Service {
  final int id;
  final String name;
  final String iconUrl;
  final double price;
  final String description;
  final bool isEnable;

  Service({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.price,
    required this.description,
    required this.isEnable,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      iconUrl: json['icon_url'] ?? '',
      price: json['price'].toDouble(),
      description: json['description'],
      isEnable: json['is_enable'],
    );
  }
}