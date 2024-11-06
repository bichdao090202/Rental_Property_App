import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/models/room.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/common/format-data.dart';

class RoomDetailScreen extends StatefulWidget  {
  final Room property;

  RoomDetailScreen({required this.property});

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();

}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  DateTime? _startDate;
  int? _rentalDuration;
  String? _messageFromRenter;
  final TextEditingController _rentalDurationController = TextEditingController();

  @override
  void dispose() {
    _rentalDurationController.dispose();
    super.dispose();
  }

  String getGender(int gender) {
    switch (gender) {
      case 1:
        return 'Nữ';
      case 2:
        return 'Nam';
      default:
        return 'Cả hai';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin phòng trọ")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.property.images[0]),
            const SizedBox(height: 16),
            Text(widget.property.title, style: const TextStyle(fontSize: 18, 
              fontWeight: FontWeight.bold, )),
            Text(
              '${formatCurrency(widget.property.price)} đ',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4511E),
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      _showBookingRequestModal();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3988),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      maximumSize: const Size(300, 40),
                    ),
                    child: const Text(
                      'Yêu cầu thuê',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      _showTermOfServiceModal(widget.property.termOfService);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3988),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      maximumSize: const Size(300, 40),
                    ),
                    child: const Text(
                      'Điều khoản dịch vụ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // SizedBox(height: 8),
            // Text("Phân loại" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            // Text(widget.property.type),

            const SizedBox(height: 8),
            const Text("Địa chỉ" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text('${widget.property.address?.provinceName}, ${widget.property.address?.districtName}, ${widget.property.address?.wardName}, ${widget.property.address?.detail}'),

            const SizedBox(height: 8),
            const Text("Mô tả" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(widget.property.description),

            const SizedBox(height: 8),

            Text('Kích thước phòng: ${widget.property.acreage} m²'),
            Text('Giới tính: ${getGender(widget.property.gender)}'),
            Text(
              'Tiện ích: ${widget.property.services!.map((u) => u.name).join(', ')}',
            ),

            const SizedBox(height: 8),
            const Text("Phí dịch vụ" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(widget.property.getChargeableServiceString()),



            const SizedBox(height: 16),



          ],
        ),
      ),
    );
  }

  void _showTermOfServiceModal(String? termOfService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Điều khoản dịch vụ'),
          content: SingleChildScrollView(
            child: Text(termOfService ?? 'Chưa có điều khoản dịch vụ.')
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }


  void _showBookingRequestModal() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Yêu cầu thuê'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // Chọn start_date
                    Row(
                      children: [
                        const Text('Ngày bắt đầu'),
                        TextButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _startDate = pickedDate;
                              });
                            }
                          },
                          child: Text(_startDate == null
                              ? 'Chọn'
                              : DateFormat('yyyy-MM-dd').format(_startDate!)),
                        ),
                      ],
                    ),

                    // Chọn rental_duration
                    Row(
                      children: [
                        const Text('Thời gian thuê '),
                        DropdownButton<int>(
                          value: _rentalDuration,
                          hint: const Text('Chọn'),
                          onChanged: (int? value) {
                            setState(() {
                              _rentalDuration = value;
                            });
                          },
                          items: [3, 6, 12].map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value tháng'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     const Text('Thời gian thuê  '),
                    //     SizedBox(
                    //       width: 80, // Giới hạn kích thước của input cho gọn
                    //       child: TextField(
                    //         controller: _rentalDurationController,
                    //         keyboardType: TextInputType.number, // Chỉ cho phép nhập số
                    //         decoration: const InputDecoration(
                    //           hintText: '',
                    //         ),
                    //         onChanged: (String value) {
                    //           setState(() {
                    //             _rentalDuration = int.tryParse(value); // Chuyển đổi chuỗi thành số nguyên
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     const Text('tháng'),
                    //   ],
                    // ),
                    // Price offered
                    // Text('Giá thuê: ${widget.property.price} VND/tháng'),
                    // SizedBox(height: 10),
                    // Textfield: Nhập message_from_renter
                    TextField(
                      decoration: const InputDecoration(labelText: 'Lời nhắn đến chủ trọ'),
                      onChanged: (value) {
                        setState(() {
                          _messageFromRenter = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () {
                    if (_startDate != null && _rentalDuration != null) {
                      BookingRequest bookingRequest = BookingRequest(
                        id: 1, // Giả lập requestId
                        renterId: 2, // Giả lập renterId
                        landlordId: widget.property.ownerId,
                        room: widget.property,
                        requestDate: DateTime.now(),
                        messageFromRenter: _messageFromRenter ?? '',
                        startDate: _startDate!,
                        rentalDuration: _rentalDuration!,
                      );

                      print('Booking request đã được tạo: ${bookingRequest.toString()}');
                      // bookingRequests.add(bookingRequest);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                      );
                    }
                  },
                  child: const Text('Gửi yêu cầu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}


