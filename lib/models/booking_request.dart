import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/models/property.dart';

class BookingRequest {
  int requestId;
  int renterId;
  int landlordId;
  Property property;
  DateTime requestDate;
  String status;
  String note;
  String messageFromRenter;
  String? messageFromLandlord;
  DateTime startDate;
  int rentalDuration;
  double priceOffered;
  DateTime? responseDate;
  int? contractId;

  // Constructor với các giá trị mặc định
  BookingRequest({
    required this.requestId,
    required this.renterId,
    required this.landlordId,
    required this.property,
    required this.requestDate,
    this.status = "Processing",
    this.note = "Waiting for landlord approval",
    required this.messageFromRenter,
    this.messageFromLandlord,
    required this.startDate,
    required this.rentalDuration,
    required this.priceOffered,
    this.responseDate,
    this.contractId,
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

  // Method cập nhật khi chủ trọ phản hồi yêu cầu
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
    responseDate = DateTime.now(); // Cập nhật thời gian phản hồi
  }

  void rejectByLandlord(String messageFromLandlord) {
    status = "Failure";
    note = "Landlord rejected";
    this.messageFromLandlord = messageFromLandlord;
    responseDate = DateTime.now(); // Cập nhật thời gian phản hồi
  }

  void approveByLandlord(int contractId) {
    status = "Processing"; // Status vẫn ở Processing cho tới khi người thuê ký và thanh toán
    note = "Waiting for renter to sign and pay";
    this.contractId = contractId;
    responseDate = DateTime.now(); // Cập nhật thời gian phản hồi
  }

  void approveByRenter() {
    status = "Success";
    note = "Active";
    // responseDate = DateTime.now(); // Cập nhật thời gian phản hồi
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

}

