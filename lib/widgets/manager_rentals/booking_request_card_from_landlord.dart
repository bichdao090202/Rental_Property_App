import 'package:flutter/material.dart';
import 'package:rental_property_app/models/booking_request.dart';

class BookingRequestCardFromLandlord extends StatefulWidget {
  final BookingRequest request;

  BookingRequestCardFromLandlord({required this.request});

  @override
  _BookingRequestCardFromLandlordState createState() => _BookingRequestCardFromLandlordState();
}

class _BookingRequestCardFromLandlordState extends State<BookingRequestCardFromLandlord> {
  void _handleApprove() {
    setState(() {
      widget.request.approveByLandlord(1);
    });
  }


  void _handleCancel() {
    setState(() {
      widget.request.rejectByLandlord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chi tiết yêu cầu đặt phòng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Request ID: ${widget.request.requestId}'),
                  Text('Trạng thái: ${widget.request.getStatusString()}'),
                  Text('Ghi chú: ${widget.request.getNoteString()}'),
                  Text('Ngày yêu cầu: ${widget.request.requestDate}'),
                  Text('Ngày bắt đầu: ${widget.request.startDate}'),
                  Text('Thời gian thuê: ${widget.request.rentalDuration} tháng'),
                  Text('Tin nhắn từ khách hàng: ${widget.request.messageFromRenter}'),
                  Text('Tin nhắn từ chủ trọ: ${widget.request.messageFromLandlord ?? "Chưa có"}'),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Hình ảnh chiếm 25% chiều rộng
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: 100, // Chiều cao cố định cho ảnh
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.request.property.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),

              // Phần chiếm 75% còn lại
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề
                    Text(
                      'Request ID: ${widget.request.requestId}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Trạng thái
                    Text(
                      'Trạng thái: ${widget.request.getStatusString()}',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 8),

                    Text('Ghi chú: ${widget.request.getNoteString()}',
                        style: TextStyle(fontSize: 12)),

                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: _getMainAxisAlignment(widget.request),
                      children: [
                        // Nút "Thanh toán" chỉ hiển thị khi request.note là "Waiting for renter to sign and pay"
                        if (widget.request.note == "Waiting for landlord approval")
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.26, // 30% chiều rộng
                            height: 30, // Điều chỉnh chiều cao thành 30
                            child: TextButton(
                              onPressed: _handleApprove,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green, // Màu xanh lá
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                maximumSize: const Size(200, 40),
                              ),
                              child: const Text(
                                'Đồng ý',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        if (widget.request.status == "Processing")
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2, // 30% chiều rộng
                            height: 30,
                            child: TextButton(
                              onPressed: _handleCancel,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red, // Màu đỏ
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                maximumSize: const Size(200, 40),
                              ),
                              child: const Text(
                                'Từ chối',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.21,
                          height: 30,
                          child: TextButton(
                            onPressed: () {
                              print('Xem bài clicked');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue, // Màu xanh
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              maximumSize: const Size(200, 40),
                            ),
                            child: const Text(
                              'Xem bài',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MainAxisAlignment _getMainAxisAlignment(BookingRequest request) {
    int buttonCount = 1;

    if (request.note == "Waiting for renter to sign and pay") {
      buttonCount++;
    }
    if (request.status == "Processing") {
      buttonCount++;
    }

    return buttonCount == 1 ? MainAxisAlignment.start : MainAxisAlignment.spaceAround;
  }
}
