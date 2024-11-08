import 'package:flutter/material.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/presentation/widgets/custom/action_button.dart';
import 'package:rental_property_app/presentation/widgets/custom/contract_dialog.dart';

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
                      'Trạng thái: ${getStatusText(widget.contract.status)} ',
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.24,
                          backgroundColor: Colors.blue,
                          text: 'Thông tin',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ContractDialog(contract: widget.contract),
                            );
                          },
                        ),
                        ActionButton(
                            width: MediaQuery.of(context).size.width * 0.22,
                            backgroundColor: Colors.green,
                            text: 'Hóa đơn',
                            onPressed: () => print('t'),
                          ),
                        if (widget.contract.status == "Active")
                        ActionButton(
                            width: MediaQuery.of(context).size.width * 0.17,
                            backgroundColor: Colors.red,
                            text: 'Hủy',
                            onPressed: () => print('t'),
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

  String getStatusText(int status) {
    switch (status) {
    // case 1:
    //   return 'Processing';
    // case 2:
    //   return 'Active';
    // case 3:
    //   return 'Finished';
    // case 4:
    //   return 'Failure';
    // case 5:
    //   return 'One-side cancel';
    // case 6:
    //   return 'Agreed cancel';
    // case 7:
    //   return 'Đang chờ thanh khoản';
    // default:
    //   return 'Unknown status';
      case 1:
        return 'Đang xử lý';
      case 2:
        return 'Đang có hiệu lực';
      case 3:
        return 'Đã kết thúc';
      case 4:
        return 'Thất bại';
      case 5:
        return 'Hủy một phía';
      case 6:
        return 'Hủy đồng thuận';
      case 7:
        return 'Đang chờ thanh khoản';
      default:
        return 'Trạng thái không xác định';
    }
  }



}
