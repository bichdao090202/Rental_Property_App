import 'package:rental_property_app/data/models/address.dart';
import 'package:rental_property_app/data/models/chargeable_service.dart';
import 'package:rental_property_app/data/models/utility.dart';

class Room { //room + status
  final int id;
  final String title;
  final String image; //list
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
  List<ChargeableService>? chargeableServices;

  Room({
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
    this.chargeableServices
  });

  Room.withDefaultAddressAndUtilities({
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
  })  : this.address = address ?? Address(id: 0, provinceName: "TP.HCM", districtName: "Gò Vấp", wardName: "Phường 1", detail: "Địa chỉ mặc định"),
        this.utilities = utilities ?? [Utility(id: 1, name: "Internet miễn phí")],
        this.termOfService = termOfService ?? "Không có điều khoản dịch vụ";

  String getChargeableServiceString() {
    return chargeableServices?.map((service) => service.getService()).join(', ') ?? 'Không có dịch vụ phụ thu';
  }



// factory Room.fromJson(Map<String, dynamic> json) {
//   print(json);
//   return Room(
//     id: json['id'],
//     title: json['title'],
//     image: (json['images'] != null && (json['images'] as List).isNotEmpty)
//         ? json['images'][0]
//         : '',
//     ownerId: json['owner_id'],
//     address: json['address'] != null ? Address.fromJson(json['address']) : null,
//     // utilities: json['utilities'] != null
//     //     ? (json['utilities'] as List).map((utility) => Utility.fromJson(utility)).toList()
//     //     : null,
//     utilities: null,
//     price: json['price'],
//     deposit: json['deposit'],
//     gender: json['gender'],
//     roomSize: json['roomSize'],
//     description: json['description'],
//     termOfService: json['termOfService'],
//     type: json['type'],
//   );
// }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0]
          : '',
      ownerId: json['owner_id'] ?? 0,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      // utilities: json['utilities'] != null
      //     ? (json['utilities'] as List).map((utility) => Utility.fromJson(utility)).toList()
      //     : [],
      utilities: [],
      price: json['price'] ?? 0.0,
      deposit: json['deposit'] ?? 0.0,
      gender: json['gender'] ?? 0,
      roomSize: json['roomSize'] ?? 0,
      description: json['description'] ?? '',
      termOfService: json['termOfService'] ?? '',
      type: json['type'] ?? '',
      // chargeableServices: json['services'] != null
      //     ? (json['services'] as List).map((service) => ChargeableService.fromJson(service)).toList()
      //     : [],
        chargeableServices:[]
    );
  }



}
