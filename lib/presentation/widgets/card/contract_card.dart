import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/common/get-status.dart';
import 'package:rental_property_app/data/models/borrowed_item.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/data/models/service.dart';
import 'package:rental_property_app/presentation/widgets/custom/action_button.dart';
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
                          // onPressed: () async {
                          //   print(widget.contract.services);
                          // },
                          onPressed: () async {
                            // Gọi showDialog để hiển thị TableInvoiceModal
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return TableInvoiceModal(
                                  services: widget.contract.services??[],
                                  deposit: widget.contract.deposit??0,
                                  month: 1,
                                );
                              },
                            );
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

                        if (widget.type == 'renter' && widget.contract.status == 4)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Đã thanh lý',
                            onPressed: () async {
                            },
                          ),

                        if (widget.type == 'lessor' && widget.contract.status == 7)
                          ActionButton(
                            width: MediaQuery.of(context).size.width * 0.35,
                            backgroundColor: Colors.orange,
                            text: 'Chờ thanh lý',
                            // onPressed: () async {
                            //   print(widget.contract.borrowItems);
                            // },
                            onPressed: () async {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true, // Cho phép bottom sheet chiếm toàn bộ màn hình
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return LiquidationModal(
                                    borrowItems: widget.contract.borrowItems!,
                                    onConfirm: (selectedItems, totalDamage) {
                                      print('Selected Items: $selectedItems');
                                      print('Total Damage: $totalDamage');
                                      Navigator.pop(context); // Đóng BottomSheet
                                    },
                                  );
                                },
                              );
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

class LiquidationModal extends StatefulWidget {
  final List<BorrowItem> borrowItems;
  final Function(List<int>, double) onConfirm;

  const LiquidationModal({
    Key? key,
    required this.borrowItems,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _LiquidationModalState createState() => _LiquidationModalState();
}

class _LiquidationModalState extends State<LiquidationModal> {
  List<int> selectedItems = [];
  double totalDamage = 0;

  void _updateTotal() {
    setState(() {
      totalDamage = widget.borrowItems
          .where((item) => selectedItems.contains(item.id))
          .fold(0, (sum, item) => sum + item.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 3,16,7),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thanh lý hợp đồng',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Danh sách vật dụng mất/hư hỏng',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Chọn các vật dụng cần thanh toán thiệt hại',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedList(
                initialItemCount: widget.borrowItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  final item = widget.borrowItems[index];
                  return SlideTransition(
                    position: animation.drive(Tween(
                      begin: Offset(1, 0),
                      end: Offset.zero,
                    )),
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          selectedItems.contains(item.id)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: selectedItems.contains(item.id)
                              ? Colors.green
                              : Colors.grey,
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          NumberFormat.currency(
                            locale: 'vi_VN',
                            symbol: '₫',
                          ).format(item.price),
                        ),
                        onTap: () {
                          setState(() {
                            if (selectedItems.contains(item.id)) {
                              selectedItems.remove(item.id);
                            } else {
                              selectedItems.add(item.id);
                            }
                            _updateTotal();
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tổng thiệt hại',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'vi_VN',
                              symbol: '₫',
                            ).format(totalDamage),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.onConfirm(selectedItems, totalDamage);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableInvoiceModal extends StatefulWidget {
  final List<Service> services;
  final double deposit;
  final int month;

  const TableInvoiceModal({
    Key? key,
    required this.services,
    required this.deposit,
    required this.month,
  }) : super(key: key);

  @override
  _TableInvoiceModalState createState() => _TableInvoiceModalState();
}

class _TableInvoiceModalState extends State<TableInvoiceModal> {
  Map<int, TextEditingController> quantityControllers = {};
  String? error;

  @override
  void initState() {
    super.initState();
    for (var service in widget.services) {
      quantityControllers[service.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    quantityControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  double calculateTotal() {
    double total = widget.deposit;
    for (var service in widget.services) {
      final quantity = int.tryParse(quantityControllers[service.id]?.text ?? '') ?? 0;
      total += service.price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tạo hóa đơn',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(),
            if (error != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Tháng: ${widget.month}'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(1.5),
                  },
                  border: TableBorder.all(
                    color: Colors.grey.shade300,
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      children: [
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Tên dịch vụ', style: TextStyle(fontWeight: FontWeight.bold)),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Đơn giá', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Số lượng', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Thành tiền', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                        )),
                      ],
                    ),
                    // Hàng tiền thuê
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                      ),
                      children: [
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Tiền thuê tháng'),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${NumberFormat("#,###").format(widget.deposit)} VNĐ',
                            textAlign: TextAlign.right,
                          ),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('1', textAlign: TextAlign.right),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${NumberFormat("#,###").format(widget.deposit)} VNĐ',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ],
                    ),
                    ...widget.services.map((service) => TableRow(
                      children: [
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(service.name),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${NumberFormat("#,###").format(service.price)} VNĐ',
                            textAlign: TextAlign.right,
                          ),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: quantityControllers[service.id],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )),
                        TableCell(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${NumberFormat("#,###").format(service.price * (int.tryParse(quantityControllers[service.id]?.text ?? '') ?? 0))} VNĐ',
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ],
                    )).toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Tổng cộng: ${NumberFormat("#,###").format(calculateTotal())} VNĐ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý tạo hóa đơn
                },
                child: Text('Tạo hóa đơn'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

