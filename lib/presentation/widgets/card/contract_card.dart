import 'package:flutter/material.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/common/get-status.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/presentation/widgets/custom/action_button.dart';
import 'package:rental_property_app/presentation/widgets/custom/contract_dialog.dart';
import 'package:rental_property_app/presentation/widgets/modal/cancel_contract_modal.dart';

class ContractCard extends StatefulWidget {
  final Contract contract;
  final String type;
  final int userId;


  ContractCard({required this.contract, required this.type, required this.userId});

  @override
  _ContractCardState createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {

  @override
  void initState() {
    super.initState();
  }

  bool isLastMonth(DateTime? startDate, int? duration) {
    if (startDate == null || duration == null) return false;

    final now = DateTime.now();
    final endDate = startDate.add(Duration(days: duration * 30));
    final difference = endDate.difference(now).inDays;

    return difference <= 30 && difference >= 0;
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    image: NetworkImage(widget.contract.room?.images[0] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${widget.contract.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Trạng thái: ${getContractStatus(widget.contract.status)} ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Ngày bắt đầu: ${widget.contract.startDate != null ? formatDay(widget.contract.startDate!) : 'Không xác định'}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Text(
                      'Thời gian thuê: ${widget.contract.rentalDuration} tháng',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Text(
                      'Giá: ${widget.contract.monthlyPrice != null ? formatCurrency(widget.contract.monthlyPrice!) : 'Không xác định'}đ/tháng',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Text(
                      'Tiền cọc: ${widget.contract.deposit != null ? formatCurrency(widget.contract.deposit!) : 'Không xác định'}đ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          backgroundColor: Colors.blue,
                          text: 'Xem PDF',
                          onPressed: () async {
                            // if (await canLaunch(contract.pdfPath)) {
                            //   await launch(contract.pdfPath);
                            // }
                          },
                        ),

                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          backgroundColor: Colors.blue[300]!,
                          text: 'Xem hóa đơn',
                          onPressed: () async {
                          },
                        ),

                        if (!isLastMonth(widget.contract.startDate, widget.contract.rentalDuration) &&
                            widget.contract.canceledBy == null &&
                            widget.contract.status == 2)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.red,
                            text: 'Hủy hợp đồng',
                            onPressed: () async {
                              _showCancelContractModal("cancel");
                            },
                          ),

                        if (isLastMonth(widget.contract.startDate, widget.contract.rentalDuration) &&
                            widget.contract.status == 1 &&
                            widget.type == 'renter' &&
                            widget.contract.status != 2 &&
                            widget.contract.status != 3)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Thanh lý',
                            onPressed: () async {
                            },
                          ),

                        if (widget.type == 'renter' && widget.contract.status == 2)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Chờ thanh lý',
                            onPressed: () async {
                            },
                          ),

                        if (widget.type == 'renter' && widget.contract.status == 4) // Assuming 4 is "Đã kết thúc"
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Đã thanh lý',
                            onPressed: () async {
                            },
                          ),

                        if (widget.type == 'lessor' && widget.contract.status == 2)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Chờ thanh lý',
                            onPressed: () async {
                            },
                          ),

                        if (widget.contract.canceledBy?.id == widget.userId && widget.contract.cancelStatus == 1)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.blue,
                            text: 'Chờ phản hồi',
                            onPressed: () async {
                              _showCancelContractModal("cancel");
                            },

                          ),

                        if (widget.contract.canceledBy?.id != widget.userId && widget.contract.cancelStatus == 1)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.blue,
                            text: 'Yêu cầu hủy',
                            onPressed: () async {
                              _showCancelContractModal("handle");
                            },
                          ),

                        if (widget.contract.canceledBy?.id == widget.userId &&
                            widget.contract.canceledBy != null &&
                            widget.contract.cancelStatus == 2)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.blue,
                            text: 'Xem phản hồi',
                            onPressed: () async {
                              _showCancelContractModal("confirm");
                            },
                          ),

                        if (widget.type == 'renter' && widget.contract.status == 1)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.green,
                            text: 'Gia hạn',
                            onPressed: () async {
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

  void _showCancelContractModal(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CancelContractModal(
          onClose: () => Navigator.of(context).pop(),
          contract: widget.contract,
          type: type,
          userId: widget.userId,
        );
      },
    );
  }





}
