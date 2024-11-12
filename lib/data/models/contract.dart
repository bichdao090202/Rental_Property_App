import 'package:rental_property_app/data/models/borrowed_item.dart';
import 'package:rental_property_app/data/models/service.dart';
import 'package:rental_property_app/data/models/room.dart';
import 'package:rental_property_app/data/models/user.dart';

class Contract {
  int id;
  User renter;
  User lessor;
  User? canceledBy;
  Room? room;
  String title;
  String content;
  DateTime? datePay;
  DateTime? startDate;
  int? rentalDuration;
  int status;
  double? monthlyPrice;
  double? deposit;
  List<Service>? services;
  String pdfPath;
  int? cancelStatus;
  int payMode;
  List<BorrowItem>? borrowItems;
  List<BorrowItem>? damagedItems;

  Contract({
    required this.id,
    required this.renter,
    required this.lessor,
    required this.title,
    required this.content,
    this.room,
    this.datePay,
    this.startDate,
    this.rentalDuration,
    this.status = 2,
    this.monthlyPrice,
    this.deposit,
    this.services,
    this.pdfPath = '',
    this.canceledBy,
    this.cancelStatus,
    this.payMode = 0,
    this.borrowItems,
    this.damagedItems,
  });

  // void completeContract(BookingRequest bookingRequest) {
  //   renter = bookingRequest.renterId;
  //   room = bookingRequest.room;
  //   startDate = bookingRequest.startDate;
  //   rentalDuration = bookingRequest.rentalDuration;
  //   monthlyPrice = bookingRequest.room.price;
  //   deposit = bookingRequest.room.deposit;
  //   services = bookingRequest.room.services;
  //   status = "Active";
  //   dateComplete = DateTime.now();
  //   datePay = DateTime.now();
  // }

  String getContractTitle() {
    if (room?.address != null && rentalDuration != null) {
      return '${room!.address?.getShortAddress()}';
    } else {
      return 'Invalid Contract';
    }
  }

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json['id'] ?? 0,
      renter: User.fromJson(json['renter'] ?? {}),
      lessor: User.fromJson(json['lessor'] ?? {}),
      canceledBy: json['canceled_by'] != null ? User.fromJson(json['canceled_by']) : null,
      room: json['room'] != null ? Room.fromJson(json['room']) : null,
      title: json['room']['title'] ?? '',
      content: json['content'] ?? '',
      datePay: json['date_pay'] != null ? DateTime.parse(json['date_pay']) : null,
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      rentalDuration: json['status'] ?? 0,
      status: json['status'] ?? 0,
      monthlyPrice: json['monthly_price']?.toDouble() ?? 0.0,
      deposit: json['deposit']?.toDouble() ?? 0.0,
      services: (json['services'] as List?)?.map((item) => Service.fromJson(item)).toList() ?? [],
      pdfPath: json['file_path'] ?? '',
      cancelStatus: json['cancel_status'] ?? 0,
      payMode: json['pay_mode'] ?? 0,
      borrowItems: (json['borrowed_items'] as List?)?.map((item) => BorrowItem.fromJson(item)).toList() ?? [],
      damagedItems: (json['damaged_items'] as List?)?.map((item) => BorrowItem.fromJson(item)).toList() ?? [],
    );
  }


}