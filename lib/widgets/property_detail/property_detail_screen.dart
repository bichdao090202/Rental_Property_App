import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_property_app/models/booking_request.dart';
import 'package:rental_property_app/models/property.dart';
import 'package:rental_property_app/widgets/manager_rentals/landlord_tab.dart';
import 'package:rental_property_app/widgets/manager_rentals/renter_tab.dart';


class PropertyDetailScreen extends StatefulWidget  {
  final Property property;

  PropertyDetailScreen({required this.property});

  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();

}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  DateTime? _startDate;
  int? _rentalDuration;
  double? _priceOffered;
  String? _messageFromRenter;

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
      appBar: AppBar(title: Text(widget.property.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.property.image),
            SizedBox(height: 16),
            Text(widget.property.type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('${widget.property.address?.city}, ${widget.property.address?.district}, ${widget.property.address?.ward}, ${widget.property.address?.detail}'),
            SizedBox(height: 8),
            Text('Giá: ${widget.property.price} VND'),
            Text('Cọc: ${widget.property.deposit} VND'),
            Text('Kích thước phòng: ${widget.property.roomSize} m²'),
            Text('Giới tính: ${getGender(widget.property.gender)}'),
            Text(
              'Tiện ích: ${widget.property.utilities!.map((u) => u.name).join(', ')}',
            ),

            SizedBox(height: 16),
            Text('Mô tả:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.property.description),
            ElevatedButton(
              onPressed: () {
                _showTermOfServiceModal(widget.property.termOfService);
              },
              child: Text('Điều khoản dịch vụ'),
            ),
            // Button: Nhắn tin với chủ trọ
            ElevatedButton(
              onPressed: () {
                // Tạm thời chưa có sự kiện
              },
              child: Text('Nhắn tin với chủ trọ'),
            ),
            // Button: Yêu cầu thuê
            ElevatedButton(
              onPressed: () {
                _showBookingRequestModal();
              },
              child: Text('Yêu cầu thuê'),
            ),

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
          title: Text('Điều khoản dịch vụ'),
          content: Text(termOfService ?? 'Chưa có điều khoản dịch vụ.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  // Hiển thị modal Yêu cầu thuê
  void _showBookingRequestModal() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Yêu cầu thuê'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // Chọn start_date
                    Row(
                      children: [
                        Text('Ngày bắt đầu'),
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
                        Text('Thời gian thuê '),
                        DropdownButton<int>(
                          value: _rentalDuration,
                          hint: Text('Chọn'),
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
                    // Price offered
                    // Text('Giá thuê: ${widget.property.price} VND/tháng'),
                    // SizedBox(height: 10),
                    // Textfield: Nhập message_from_renter
                    TextField(
                      decoration: InputDecoration(labelText: 'Lời nhắn đến chủ trọ'),
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
                  child: Text('Hủy'),
                ),
                TextButton(
                  onPressed: () {
                    if (_startDate != null && _rentalDuration != null) {
                      BookingRequest bookingRequest = BookingRequest(
                        requestId: 1, // Giả lập requestId
                        renterId: 2, // Giả lập renterId
                        landlordId: widget.property.ownerId,
                        property: widget.property,
                        requestDate: DateTime.now(),
                        messageFromRenter: _messageFromRenter ?? '',
                        startDate: _startDate!,
                        rentalDuration: _rentalDuration!,
                        priceOffered: widget.property.price.toDouble(),
                      );

                      print('Booking request đã được tạo: ${bookingRequest.toString()}');

                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                      );
                    }
                  },
                  child: Text('Gửi yêu cầu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}


