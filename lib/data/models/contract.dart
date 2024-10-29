import 'package:rental_property_app/models/booking_request.dart';
import 'package:rental_property_app/models/chargeable_service.dart';
import 'package:rental_property_app/models/property.dart';

class Contract {
  int id;
  int? renterId;
  int landlordId;
  Property? property;
  String name;
  String content;
  DateTime? dateComplete;
  DateTime? datePay;
  DateTime? startRentDate;
  int? rentalDuration;
  String status;
  double? price;
  double? deposit;
  List<ChargeableService>? chargeableServices;
  String pdfPath;

  Contract({
    required this.id,
    this.renterId,
    required this.landlordId,
    this.property,
    required this.name,
    required this.content,
    this.dateComplete,
    this.datePay,
    this.startRentDate,
    this.rentalDuration,
    this.status = "Active",
    required this.pdfPath,
  });

  void completeContract(BookingRequest bookingRequest) {
    renterId = bookingRequest.renterId;
    property = bookingRequest.property;
    startRentDate = bookingRequest.startDate;
    rentalDuration = bookingRequest.rentalDuration;
    price = bookingRequest.property.price;
    deposit = bookingRequest.property.deposit;
    chargeableServices = bookingRequest.property.chargeableServices;

    status = "Active";

    dateComplete = DateTime.now();
    datePay = DateTime.now();
  }

  String getContractTitle() {
    if (property?.address != null && rentalDuration != null) {
      return '${property!.address?.getShortAddress()}';
    } else {
      return 'Invalid Contract';
    }
  }

}