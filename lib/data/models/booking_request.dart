import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/models/borrowed_item.dart';
import 'package:rental_property_app/data/models/room.dart';

class BookingRequest {
  int id;
  int renterId;
  int landlordId;
  int cancelBy;
  Room room;
  DateTime requestDate;
  String status;
  String note;
  String messageFromRenter;
  String? messageFromLandlord;
  DateTime startDate;
  int rentalDuration;
  DateTime? responseDate;
  int? contractId;
  List<BorrowItem>? borrowItems;

  BookingRequest({
    required this.id,
    required this.renterId,
    required this.landlordId,
    required this.room,
    required this.requestDate,
    this.status = "Processing",
    this.note = "Waiting for landlord approval",
    required this.messageFromRenter,
    this.messageFromLandlord,
    required this.startDate,
    required this.rentalDuration,
    this.responseDate,
    this.contractId,
    this.borrowItems,
    this.cancelBy = 0,
  });

  String getStartDate(){
    return formatDay(startDate);
  }

  String getResponseDate(){
    return formatDatetime(responseDate!);
  }

  String getRequestDate(){
    return formatDatetime(requestDate);
  }

  void updateResponseFromLandlord(String message, String status, DateTime responseDate) {
    this.messageFromLandlord = message;
    this.status = status;
    this.responseDate = responseDate;
  }

  void markAsExpired() {
    this.status = "Expired";
  }

  void cancelByRenter() {
    status = "Failure";
    note = "Renter canceled";
    responseDate = DateTime.now();
  }

  void rejectByLandlord(String messageFromLandlord) {
    status = "Failure";
    note = "Landlord rejected";
    this.messageFromLandlord = messageFromLandlord;
    responseDate = DateTime.now();
  }

  void approveByLandlord(int contractId) {
    status = "Processing";
    note = "Waiting for renter to sign and pay";
    this.contractId = contractId;
    responseDate = DateTime.now();
  }

  void approveByRenter() {
    status = "Success";
    note = "Success";
    // responseDate = DateTime.now();
  }

  String getStatusString() {
    switch (status) {
      case 'Processing':
          return 'Đang xử lý';
      case 'Success':
          return 'Thành công';
      case 'Failure':
          return 'Thất bại';
      default:
        return 'Không xác định';
    }
  }

  String getStatus(){
    return status;
  }

  String getNoteString() {
    switch (note) {
      case 'Waiting for landlord approval':
        return 'Đang chờ chủ trọ đồng ý';
      case 'Waiting for renter to sign and pay':
        return 'Đang chờ khách hàng ký và thanh toán';
      case 'Active':
        return 'Đang có hiệu lực';
      case 'Expired':
        return 'Hết hạn';
      case 'Landlord rejected':
        return 'Chủ trọ từ chối';
      case 'Renter canceled':
        return 'Khách hàng hủy';
      default:
        return 'Không xác định';
    }
  }

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      id: json['id'] ?? 0,
      renterId: json['renter_id'] ?? 0,
      landlordId: json['lessor_id'] ?? 0,
      cancelBy: json['cancel_by'] ?? 0,
      room: Room.fromJson(json['room'] ?? {}),
      requestDate: DateTime.tryParse(json['request_date'] ?? '') ?? DateTime(0),
      status: json['status'] ?? "Processing",
      note: json['note'] ?? "Waiting for landlord approval",
      messageFromRenter: json['message_from_renter'] ?? "",
      messageFromLandlord: json['message_from_lessor'] ?? "",
      startDate: DateTime.tryParse(json['start_date'] ?? '') ?? DateTime(0),
      rentalDuration: json['rental_duration'] ?? 0,
      contractId: json['contract_id'] ?? 0,
    );
  }


  @override
  String toString() {
    return 'BookingRequest(id: $id, renterId: $renterId, landlordId: $landlordId, '
        'cancelBy: $cancelBy, room: ${room.toString()}, requestDate: $requestDate, '
        'status: $status, note: $note, messageFromRenter: $messageFromRenter, '
        'messageFromLandlord: $messageFromLandlord, startDate: $startDate, '
        'rentalDuration: $rentalDuration, responseDate: $responseDate, '
        'contractId: $contractId, borrowItems: ${borrowItems.toString()})';
  }


}

