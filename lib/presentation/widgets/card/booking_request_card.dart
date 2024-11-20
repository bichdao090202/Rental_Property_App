import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rental_property_app/common/file-base64.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/widgets/custom/action_button.dart';

class BookingRequestCard extends StatefulWidget {
  final BookingRequest request;
  final String type;
  final int userId;

  BookingRequestCard({required this.request, required this.type, required this.userId});

  @override
  _BookingRequestCardState createState() => _BookingRequestCardState();
}

class _BookingRequestCardState extends State<BookingRequestCard>  {
  bool _agreeWithContract = false;
  bool _agreeWithPlatformRules = false;
  Contract? _contract;
  bool _isLoading = true;
  int? _selectedContractId;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
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
              padding: const EdgeInsets.all(16),
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
                  const SizedBox(height: 16),
                  Text('Request ID: ${widget.request.id}'),
                  Text('Trạng thái: ${widget.request.getStatusString()}'),
                  Text('Ghi chú: ${widget.request.getNoteString()}'),
                  Text('Ngày yêu cầu: ${widget.request.getRequestDate()}'),
                  Text('Ngày bắt đầu: ${widget.request.getStartDate()}'),
                  Text('Thời gian thuê: ${widget.request.rentalDuration} tháng'),
                  Text('Tin nhắn từ khách hàng: ${widget.request.messageFromRenter}'),
                  // Text('Tin nhắn từ chủ trọ: ${widget.request.messageFromLandlord ?? "Chưa có"}'),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    // image: NetworkImage(widget.request.room.images[0]),
                    image: (widget.request.room != null && widget.request.room.images.isNotEmpty)
                        ? NetworkImage(widget.request.room.images[0])
                        : AssetImage('assets/images/default_image.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề
                    Text(
                      'ID: ${widget.request.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Trạng thái
                    Text(
                      // 'Trạng thái: ${widget.request.getStatusString()}',
                      'Trạng thái: ${widget.request.status}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Text('Ngày bắt đầu: ${widget.request.getStartDate()}',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Text('Thời gian thuê: ${widget.request.rentalDuration} tháng',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Text('Tin nhắn từ khách hàng: ${widget.request.messageFromRenter}',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Text('Giá phòng: ${ formatCurrency(widget.request.room.price) } vnđ ',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    // Row(
                    //   mainAxisAlignment: _getMainAxisAlignment(widget.request),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: _getMainAxisAlignment(widget.request) == MainAxisAlignment.start
                          ? WrapAlignment.start
                          : WrapAlignment.spaceAround,
                      children: [
                        if (widget.request.note == "Waiting for renter to sign and pay")
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Color(0xFF008080),
                            text: 'Xem File',
                            onPressed: () async {
                              try {
                                final bytes = base64Decode(widget.request.messageFromLandlord!);
                                final tempDir = await getTemporaryDirectory();

                                // final filePath = '${tempDir.path}/file.pdf';

                                final timestamp = DateTime.now().millisecondsSinceEpoch;
                                final filePath = '${tempDir.path}/file_$timestamp.pdf';
                                final file = File(filePath);
                                await file.writeAsBytes(bytes);

                                await OpenFilex.open(filePath);
                              } catch (e) {
                                print('Error opening file: $e');
                              }
                            },
                          ),

                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          // backgroundColor: Colors.blue,
                          text: 'Xem phòng',
                          onPressed: () {
                            print('Xem bài clicked');
                          },
                        ),

                        if (widget.type == "renter") ...[
                          if (widget.request.note == "Waiting for renter to sign and pay")
                            ActionButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              backgroundColor: Colors.green,
                              text: 'Thanh toán',
                              onPressed: () {
                                _showPaymentDialog1();
                                print('Thanh toán clicked');
                              },
                            ),
                          if (widget.request.status != "Success")
                            ActionButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              backgroundColor: Color(0xFF607D8B),
                              text: 'Hủy',
                              onPressed: () {
                                print('Hủy clicked');
                              },
                            ),
                        ] else ...[
                          if (widget.request.note == "Waiting for landlord approval")
                            ActionButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              backgroundColor: Colors.green,
                              text: 'Đồng ý',
                              onPressed: _handleApprove,
                            ),
                          if (widget.request.status != "Success")
                            ActionButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              backgroundColor: Colors.red,
                              text: 'Từ chối',
                              // onPressed: _handleCancel,
                              onPressed: () {
                                print('Từ chối clicked');
                              },
                            ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showPaymentDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Thông tin thanh toán',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chọn nhà cung cấp chữ ký số',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: 'Viettel',
                                      items: ['Viettel'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chi tiết thanh toán',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              _buildPaymentRow('Tiền cọc:', '${formatCurrency(widget.request.room.deposit)} VNĐ'),
                              _buildPaymentRow('Tiền thuê tháng 1:', '${formatCurrency(widget.request.room.price)} VNĐ'),
                              Divider(),
                              _buildPaymentRow(
                                'Tổng cộng:',
                                '${widget.request.room.deposit + widget.request.room.price} VNĐ',
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Đóng'),
                          ),
                          ElevatedButton(
                            onPressed: () async {

                              // final signedData = await ApiService().postSign('sign/sign_document', widget.request.messageFromLandlord!);
                              // if (signedData!=null) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Chữ ký hợp lệ, chờ cập nhật')),
                              //   );
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Ký thất bại, thử lại sau')),
                              //   );
                              //   Navigator.of(context).pop();
                              //   return;
                              // }

                              final timestamp = DateTime.now().millisecondsSinceEpoch;

                              Map<String, dynamic> bookingData = {
                                'booking_request_id': widget.request.id,
                                'pay_for': 2,
                                'file_base64': widget.request.messageFromLandlord,
                                "file_name": "$timestamp.pdf",
                              };

                              final bookingResponse = await ApiService().createContract(bookingData);
                              // print(bookingResponse);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Thao tác thành công')),
                              );
                              Navigator.of(context).pop();

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text('Xác nhận'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


  void _handleApprove() {
    String? _selectedPaymentMethod;
    String? _selectedSignProvider;
    String? _selectedFileName;
    PlatformFile? _selectedFile;

    bool isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Chọn hợp đồng cho yêu cầu thuê',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rental Information
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.calendar_today,
                                    'Ngày bắt đầu',
                                    widget.request.getStartDate(),
                                  ),
                                  SizedBox(height: 8),
                                  _buildInfoRow(
                                    Icons.timelapse,
                                    'Thời gian thuê',
                                    '${widget.request.rentalDuration} tháng',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),

                            // Payment Method Selection
                            // Text(
                            //   'Phương thức thanh toán',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey[300]!),
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: DropdownButtonHideUnderline(
                            //     child: DropdownButton<String>(
                            //       value: _selectedPaymentMethod,
                            //       isExpanded: true,
                            //       hint: Padding(
                            //         padding: EdgeInsets.symmetric(horizontal: 12),
                            //         child: Text('Chọn phương thức thanh toán'),
                            //       ),
                            //       padding: EdgeInsets.symmetric(horizontal: 12),
                            //       items: [
                            //         DropdownMenuItem(
                            //           value: 'wallet',
                            //           child: Row(
                            //             children: [
                            //               Icon(Icons.account_balance_wallet,
                            //                   color: Theme.of(context).primaryColor),
                            //               SizedBox(width: 8),
                            //               Text('Ví hệ thống'),
                            //             ],
                            //           ),
                            //         ),
                            //         DropdownMenuItem(
                            //           value: 'bank',
                            //           child: Row(
                            //             children: [
                            //               Icon(Icons.account_balance,
                            //                   color: Theme.of(context).primaryColor),
                            //               SizedBox(width: 8),
                            //               Text('Ngân hàng'),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //       onChanged: (value) {
                            //         setStateDialog(() {
                            //           _selectedPaymentMethod = value;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 24),

                            // Digital Signature Provider
                            Text(
                              'Nhà cung cấp chữ ký số',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedSignProvider,
                                  isExpanded: true,
                                  hint: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text('Chọn nhà cung cấp'),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'viettel',
                                      child: Text('Viettel'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'vnpt',
                                      child: Text('VNPT'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      _selectedSignProvider = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 24),

                            // File Selection
                            Text(
                              'Tài liệu hợp đồng',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                );

                                if (result != null) {
                                  setStateDialog(() {
                                    _selectedFile = result.files.first;
                                    _selectedFileName = result.files.first.name;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    // style: BorderStyle.dashed,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.upload_file,
                                      size: 32,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      _selectedFileName ?? 'Chọn file PDF',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    if (_selectedFileName != null)
                                      Text(
                                        '(Nhấn để chọn file khác)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Actions
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Hủy'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed:  () async {
                              if (
                                  _selectedSignProvider == null ||
                                  _selectedFile == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Vui lòng điền đầy đủ thông tin',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              setStateDialog(() {
                                isLoading = true;
                              });


                              String base64String = await encodeFileToBase64(null, _selectedFile);

                              print('da gui');
                              final signedData = await ApiService().postSign('sign/sign_document', base64String);
                              print('signedData ${signedData}' );
                              if (signedData!=null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Chữ ký hợp lệ, chờ cập nhật')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Ký thất bại, thử lại sau')),
                                );
                                Navigator.of(context).pop();
                                return;
                              }

                                Map<String, dynamic> bookingData = {
                                  'id': widget.request.id,
                                  'renter_id': widget.request.renterId,
                                  'lessor_id': widget.request.landlordId,
                                  'room_id': widget.request.room.id,
                                  'status': "PROCESSING",
                                  'note': "Waiting for renter to sign and pay",
                                  'message_from_renter': widget.request.messageFromRenter,
                                  'start_date': widget.request.startDate.toUtc().toIso8601String(),
                                  'rental_duration': widget.request.rentalDuration,
                                  "message_from_lessor": signedData,
                                };

                                final bookingResponse = await ApiService().updateBookingRequest(bookingData, widget.request.id);

                              setStateDialog(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã ký thành công')),
                              );
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Text('Xác nhận'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
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
    // return buttonCount == 1 ? MainAxisAlignment.start : MainAxisAlignment.spaceAround;
    return MainAxisAlignment.spaceAround;
  }

}
