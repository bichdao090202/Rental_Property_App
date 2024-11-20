import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/models/room.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';

class RoomDetailScreen extends StatefulWidget  {
  final Room room;

  RoomDetailScreen({required this.room});

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();

}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  DateTime? _startDate;
  int? _rentalDuration;
  String? _messageFromRenter;
  bool isLoading = false;
  final TextEditingController _rentalDurationController = TextEditingController();
  final ApiService apiService = ApiService();

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

  Future<void> sendBookingRequest(DateTime startDate, int rentalDuration, String messageFromRenter) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userInfo?.id;
    final room = widget.room;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể lấy thông tin người dùng')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> bookingData = {
      'renter_id': userId,
      'lessor_id': room.ownerId,
      'room_id': room.id,
      'status': "PROCESSING",
      'note': "Waiting for landlord approval",
      'message_from_renter': messageFromRenter,
      'start_date': startDate.toUtc().toIso8601String(),
      'rental_duration': rentalDuration,
    };




    final response = await apiService.createBookingRequest(bookingData);

    if (response['status'] == "SUCCESS") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã gửi yêu cầu đặt phòng thành công')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thao tác thất bại, vui lòng thử lại')),
      );
    }
    Navigator.pop(context);

    // Map<String, dynamic> bookingData = {
    //   'room_id': 123,
    //   'user_id': 456,
    //   'start_date': DateTime.now().toIso8601String(),
    // };
    // final success = await apiService.createBookingRequest(bookingData);

    setState(() {
      isLoading = false;
    });

    // if (success) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Đặt phòng thành công!')),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Đặt phòng thất bại, vui lòng thử lại!')),
    //   );
    // }
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
            Image.network(widget.room.images[0]),
            const SizedBox(height: 16),
            Text(widget.room.title, style: const TextStyle(fontSize: 18,
              fontWeight: FontWeight.bold, )),
            Text(
              '${formatCurrency(widget.room.price)} đ',
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
                      _showTermOfServiceModal(widget.room.termOfService);
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
            Text('${widget.room.address?.provinceName}, ${widget.room.address?.districtName}, ${widget.room.address?.wardName}, ${widget.room.address?.detail}'),
            const SizedBox(height: 8),
            const Text("Mô tả" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(widget.room.description),
            const SizedBox(height: 8),
            Text('Kích thước phòng: ${widget.room.acreage} m²'),
            Text('Giới tính: ${getGender(widget.room.gender)}'),
            Text(
              'Tiện ích: ${widget.room.services!.map((u) => u.name).join(', ')}',
            ),
            const SizedBox(height: 8),
            const Text("Phí dịch vụ" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(widget.room.getChargeableServiceString()),
            const SizedBox(height: 16),
            const Text("Vật dụng đi kèm" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

            ListView.builder(
              shrinkWrap: true, // Điều chỉnh chiều cao theo nội dung
              physics: NeverScrollableScrollPhysics(), // Ngăn ListView cuộn nếu đã có cuộn cha
              itemCount: widget.room.borrowItems!.length,
              itemBuilder: (context, index) {
                final item = widget.room.borrowItems![index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('${formatCurrency(item.price)} đ'),
                );
              },
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
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _rentalDurationController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '',
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _rentalDuration = int.tryParse(value);
                              });
                            },
                          ),
                        ),
                        const Text('tháng'),
                      ],
                    ),
                    SizedBox(height: 10),
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
                    if (_startDate != null && _rentalDuration != null && _messageFromRenter != null) {
                      sendBookingRequest(_startDate!, _rentalDuration!, _messageFromRenter!);
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