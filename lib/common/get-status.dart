String getContractStatus(int status) {
  switch (status) {
    case 1:
      return "Đang xử lý";
    case 2:
      return "Đang có hiệu lực";
    case 3:
      return "Đã kết thúc";
    case 4:
      return "Thất bại";
    case 5:
      return "Hủy một phía";
    case 6:
      return "Hủy đồng thuận";
    case 7:
      return "Đang chờ thanh khoản";
    case 8:
      return "Đã thanh khoản";
    default:
      return "Trạng thái không xác định";
  }
}

String getCancelContractStatus(int status) {
  switch (status) {
    case 1:
      return "Đã gửi yêu cầu hủy";
    case 2:
      return "Đã phản hồi";
    case 3:
      return "Hoàn thành";
    default:
      return "Trạng thái không xác định";
  }
}
