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

  // Method cập nhật khi chủ trọ phản hồi yêu cầu
  void updateResponseFromLandlord(String message, String status, DateTime responseDate) {
    this.messageFromLandlord = message;
    this.status = status;
    this.responseDate = responseDate;
  }

  // Method cập nhật khi hợp đồng được ký
  void updateContract(int contractId) {
    this.contractId = contractId;
    this.status = "Contract Signed";
  }

  // Method cập nhật trạng thái khi hợp đồng hết hạn
  void markAsExpired() {
    this.status = "Expired";
  }

  // Method từ chối yêu cầu
  void rejectRequest(String reason) {
    this.status = "Rejected";
    this.note = reason;
  }

  // Method hủy yêu cầu
  void cancelRequest(String reason) {
    this.status = "Cancelled";
    this.note = reason;
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

