

import 'package:rental_property_app/data/models/chargeable_service.dart';
import 'package:rental_property_app/data/models/room.dart';

import 'booking_request.dart';

class Contract {
  int id;
  int? renterId;
  int landlordId;
  int? canceledBy;
  Room? room;
  String title;
  String content;
  DateTime? dateComplete;
  DateTime? datePay;
  DateTime? startDate;
  int? rentalDuration;
  String status;
  double? monthlyPrice;
  double? deposit;
  List<ChargeableService>? chargeableServices;
  String pdfPath;
  int? cancelStatus;


  Contract({
    required this.id,
    this.renterId,
    required this.landlordId,
    this.room,
    required this.title,
    required this.content,
    this.dateComplete,
    this.datePay,
    this.startDate,
    this.rentalDuration,
    this.status = "Active",
    required this.pdfPath,
    this.monthlyPrice,
    this.deposit,
    this.chargeableServices,
    this.canceledBy,
    this.cancelStatus,
  });

  void completeContract(BookingRequest bookingRequest) {
    renterId = bookingRequest.renterId;
    room = bookingRequest.room;
    startDate = bookingRequest.startDate;
    rentalDuration = bookingRequest.rentalDuration;
    monthlyPrice = bookingRequest.room.price;
    deposit = bookingRequest.room.deposit;
    chargeableServices = bookingRequest.room.chargeableServices;

    status = "Active";

    dateComplete = DateTime.now();
    datePay = DateTime.now();
  }

  String getContractTitle() {
    if (room?.address != null && rentalDuration != null) {
      return '${room!.address?.getShortAddress()}';
    } else {
      return 'Invalid Contract';
    }
  }

  factory Contract.fromJson(Map<String, dynamic> json) {
    // Parse room from JSON
    Room? room = json['room'] != null ? Room.fromJson(json['room']) : null;

    // Parse chargeable services if any
    // List<ChargeableService>? chargeableServices = (json['services'] as List<dynamic>?)
    //     ?.map((service) => ChargeableService.fromJson(service))
    //     .toList();

    return Contract(
      id: json['id'],
      renterId: json['renter']?['id'],
      landlordId: json['lessor']['id'],
      room: room,
      title: room?.title ?? 'No Title',
      content: room?.description ?? 'No Description',
      dateComplete: json['date_complete'] != null ? DateTime.parse(json['date_complete']) : null,
      datePay: json['date_pay'] != null ? DateTime.parse(json['date_pay']) : null,
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      rentalDuration: json['payment'], // Adjust based on your API design
      status: json['status'].toString(),
      monthlyPrice: json['monthly_price']?.toDouble(),
      deposit: json['room']?['deposit']?.toDouble(),
      chargeableServices: [],
      pdfPath: json['file_path'],
      canceledBy: json['canceled_by'],
    );
  }

}