import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/widgets/custom/action_button.dart';

class BookingRequestCardFromRenter extends StatefulWidget {
  final BookingRequest request;

  BookingRequestCardFromRenter({required this.request});

  @override
  _BookingRequestCardFromRenterState createState() => _BookingRequestCardFromRenterState();
}

class _BookingRequestCardFromRenterState extends State<BookingRequestCardFromRenter> {
  bool _agreeWithContract = false;
  bool _agreeWithPlatformRules = false;
  Contract? _contract;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Contract contract = getContractById(widget.request.contractId!);
    setState(() {
      _contract = contract;
      _isLoading = false;
    });
  }


  void _handleApprove() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Nội dung hợp đồng'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(_contract!.content),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeWithContract,
                          onChanged: (bool? value) {
                            setStateDialog(() {
                              _agreeWithContract = value ?? false;
                            });
                          },
                        ),
                        const Flexible(child: Text('Tôi đồng ý chấp thuận với yêu cầu của hợp đồng'))
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeWithPlatformRules,
                          onChanged: (bool? value) {
                            setStateDialog(() {
                              _agreeWithPlatformRules = value ?? false;
                            });
                          },
                        ),
                        Flexible(
                            child: InkWell(
                              onTap: () {
                                _togglePlatformRules();
                              },
                              child: const Text(
                                'Tôi đồng ý tuân thủ các quy định của nền tảng',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Huỷ'),
                ),

                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextButton(
                    onPressed: (_agreeWithContract && _agreeWithPlatformRules)
                        ? () {
                      setState(() {
                        widget.request.approveByRenter();
                      });
                      updateContractById(widget.request.contractId!, widget.request);
                      Navigator.pop(context);
                    }
                        : null,
                    style: TextButton.styleFrom(
                      backgroundColor: (_agreeWithContract && _agreeWithPlatformRules)
                          ? Colors.green
                          : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      maximumSize: const Size(200, 40),
                    ),
                    child: const Text(
                      'Đồng ý và thanh toán',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _togglePlatformRules() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quy định nền tảng'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(platformRules),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

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
                  Text('Request ID: ${widget.request.requestId}'),
                  Text('Trạng thái: ${widget.request.getStatusString()}'),
                  Text('Ghi chú: ${widget.request.getNoteString()}'),
                  Text('Ngày yêu cầu: ${widget.request.getRequestDate()}'),
                  Text('Ngày bắt đầu: ${widget.request.getStartDate()}'),
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
                    image: NetworkImage(widget.request.property.image),
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
                      'Request ID: ${widget.request.requestId}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Trạng thái
                    Text(
                      'Trạng thái: ${widget.request.getStatusString()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Text('Ghi chú: ${widget.request.getNoteString()}',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Text('Ngày bắt đầu: ${widget.request.getStartDate()}',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Text('Thời gian thuê: ${widget.request.rentalDuration} tháng',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 3),

                    Row(
                      mainAxisAlignment: _getMainAxisAlignment(widget.request),
                      children: [
                        if (widget.request.note == "Waiting for renter to sign and pay")
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.26,
                            backgroundColor: Colors.green,
                            text: 'Thanh toán',
                            onPressed: _handleApprove,
                          ),
                        if (widget.request.status == "Processing")
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.15,
                            backgroundColor: Colors.red,
                            text: 'Hủy',
                            onPressed: _handleCancel,
                          ),
                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.21,
                          backgroundColor: Colors.blue,
                          text: 'Xem bài',
                          onPressed: () {
                            print('Xem bài clicked');
                          },
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
