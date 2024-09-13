import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/models/booking_request.dart';
import 'package:rental_property_app/models/contract.dart';

class BookingRequestCardFromRenter extends StatefulWidget {
  final BookingRequest request;

  BookingRequestCardFromRenter({required this.request});

  @override
  _BookingRequestCardFromRenterState createState() => _BookingRequestCardFromRenterState();
}

class _BookingRequestCardFromRenterState extends State<BookingRequestCardFromRenter> {
  // void _handleApprove() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Hợp đồng thuê nhà'),
  //         content: SingleChildScrollView(
  //             // child: Text()
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Đóng'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   setState(() {
  //     widget.request.approveByRenter();
  //   });
  // }

  // void _handleApprove() {
  //   bool _agreeWithContract = false;
  //   bool _agreeWithPlatformRules = false;
  //
  //   void _togglePlatformRules(BuildContext context) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Quy định của nền tảng'),
  //           content: SingleChildScrollView(
  //             child: Text('Nội dung quy định của nền tảng...'),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context); // Đóng hộp quy định
  //               },
  //               child: Text('Đóng'),
  //             ),
  //           ],
  //         );
  //       },
  //     ).then((_) {
  //       // Sau khi đóng hộp quy định, mở lại hộp hợp đồng
  //       _handleApprove(); // Mở lại hộp hợp đồng
  //     });
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //             title: Text('Hợp đồng thuê nhà'),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   FutureBuilder<Contract?>(
  //                     future: Future.delayed(Duration.zero, () => getContractById(widget.request.contractId!)),
  //                     builder: (context, snapshot) {
  //                       if (snapshot.connectionState == ConnectionState.waiting) {
  //                         return CircularProgressIndicator();
  //                       } else if (snapshot.hasData) {
  //                         final contract = snapshot.data;
  //                         if (contract != null) {
  //                           return Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text('Tên hợp đồng: ${contract.name}', style: TextStyle(fontWeight: FontWeight.bold)),
  //                               SizedBox(height: 8),
  //                               Text(contract.content),
  //                             ],
  //                           );
  //                         } else {
  //                           return Text('Hợp đồng không tìm thấy');
  //                         }
  //                       } else {
  //                         return Text('Lỗi khi lấy dữ liệu hợp đồng');
  //                       }
  //                     },
  //                   ),
  //                   SizedBox(height: 16),
  //                   Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _agreeWithContract,
  //                         onChanged: (value) {
  //                           setState(() {
  //                             _agreeWithContract = value ?? false;
  //                           });
  //                         },
  //                       ),
  //                       Text('Đồng ý với hợp đồng'),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _agreeWithPlatformRules,
  //                         onChanged: (value) {
  //                           setState(() {
  //                             _agreeWithPlatformRules = value ?? false;
  //                             if (_agreeWithPlatformRules) {
  //                               _togglePlatformRules(context);
  //                             }
  //                           });
  //                         },
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           _togglePlatformRules(context);
  //                         },
  //                         child: Text(
  //                           'Đồng ý với quy định của nền tảng',
  //                           style: TextStyle(color: Colors.blue),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Đóng'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   // Xử lý đồng ý và thanh toán
  //                   widget.request.approveByRenter();
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Đồng ý và thanh toán'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  bool _isChecked1 = false; // Trạng thái checkbox 1
  bool _isChecked2 = false;
  void _handleApprove() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) { // Quản lý trạng thái của dialog
            return AlertDialog(
              title: Text('Nội dung hợp đồng'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Đây là nội dung của hợp đồng...'),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked1,
                          onChanged: (bool? value) {
                            setStateDialog(() { // Cập nhật trạng thái bên trong dialog
                              _isChecked1 = value ?? false;
                            });
                          },
                        ),
                        Text('Tôi đồng ý với điều khoản 1'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked2,
                          onChanged: (bool? value) {
                            setStateDialog(() { // Cập nhật trạng thái bên trong dialog
                              _isChecked2 = value ?? false;
                            });
                          },
                        ),
                        Text('Tôi đồng ý với điều khoản 2'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: Text('Huỷ'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_isChecked1 && _isChecked2) {
                      Navigator.of(context).pop(); // Đóng dialog sau khi xác nhận
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bạn cần đồng ý với cả hai điều khoản!')),
                      );
                    }
                  },
                  child: Text('Xác nhận'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // void _handleApprove() {
  //   bool _agreeWithContract = false;
  //   bool _agreeWithPlatformRules = false;
  //   bool _showPlatformRules = false;
  //
  //   void _togglePlatformRules() {
  //     setState(() {
  //       _showPlatformRules = !_showPlatformRules;
  //     });
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Hợp đồng thuê nhà'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               if (!_showPlatformRules) ...[
  //                 FutureBuilder<Contract?>(
  //                   future: Future.delayed(Duration.zero, () => getContractById(widget.request.contractId!)),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.connectionState == ConnectionState.waiting) {
  //                       return CircularProgressIndicator();
  //                     } else if (snapshot.hasData) {
  //                       final contract = snapshot.data;
  //                       if (contract != null) {
  //                         return Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             // Text('Tên hợp đồng: ${contract.name}', style: TextStyle(fontWeight: FontWeight.bold)),
  //                             SizedBox(height: 8),
  //                             Text(contract.content),
  //                           ],
  //                         );
  //                       } else {
  //                         return Text('Hợp đồng không tìm thấy');
  //                       }
  //                     } else {
  //                       return Text('Lỗi khi lấy dữ liệu hợp đồng');
  //                     }
  //                   },
  //                 ),
  //                 SizedBox(height: 16),
  //                 Row(
  //                   children: [
  //                     Checkbox(
  //                       value: _agreeWithContract,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           _agreeWithContract = value ?? false;
  //                         });
  //                       },
  //                     ),
  //                     Text('Đồng ý với hợp đồng'),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Checkbox(
  //                       value: _agreeWithPlatformRules,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           _agreeWithPlatformRules = value ?? false;
  //                         });
  //                         if (value == true) {
  //                           _togglePlatformRules();
  //                         }
  //                       },
  //                     ),
  //                     Text('Đồng ý với quy định của nền tảng', style: TextStyle(color: Colors.blue)),
  //                   ],
  //                 ),
  //                 if (_showPlatformRules)
  //                   AlertDialog(
  //                     title: Text('Quy định của nền tảng'),
  //                     content: SingleChildScrollView(
  //                       child: Text('Nội dung quy định của nền tảng...'),
  //                     ),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {
  //                           _togglePlatformRules();
  //                         },
  //                         child: Text('Đóng'),
  //                       ),
  //                     ],
  //                   ),
  //               ] else ...[
  //                 // Nội dung khi hiện quy định của nền tảng
  //                 Text('Quy định của nền tảng: Nội dung quy định...'),
  //               ],
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Đóng'),
  //           ),
  //           ElevatedButton(
  //             onPressed: (_agreeWithContract && _agreeWithPlatformRules)
  //                 ? () {
  //               // Handle approval and payment here
  //               setState(() {
  //                 widget.request.approveByRenter();
  //               });
  //               Navigator.pop(context);
  //             }
  //                 : null,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: (_agreeWithContract && _agreeWithPlatformRules)
  //                   ? Colors.blueAccent
  //                   : Colors.blueGrey,
  //             ),
  //             child: Text('Đồng ý và thanh toán'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }





  void _handleCancel() {
    setState(() {
      widget.request.cancelByRenter();
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
                        if (widget.request.note == "Waiting for renter to sign and pay")
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
                                'Thanh toán',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        // Nút "Hủy" chỉ hiển thị khi trạng thái là "Processing"
                        if (widget.request.status == "Processing")
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15, // 30% chiều rộng
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
                                'Hủy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        // Nút "Xem bài" luôn hiển thị
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
