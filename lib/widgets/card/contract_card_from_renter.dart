import 'package:flutter/material.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/models/contract.dart';
import 'package:rental_property_app/widgets/custom/action_button.dart';
import 'package:rental_property_app/widgets/custom/contract_dialog.dart';

class ContractCardFromRenter extends StatefulWidget {
  final Contract contract;

  ContractCardFromRenter({required this.contract});

  @override
  _ContractCardFromRenterState createState() => _ContractCardFromRenterState();
}

class _ContractCardFromRenterState extends State<ContractCardFromRenter> {

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
                    image: NetworkImage(widget.contract.property?.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contract.getContractTitle(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ngày bắt đầu: ${widget.contract.startRentDate != null ? formatDay(widget.contract.startRentDate!) : 'Không xác định'}',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 3),

                    Text(
                      'Thời gian thuê: ${widget.contract.rentalDuration} tháng',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 3),

                    Text(
                      'Giá: ${widget.contract.price != null ? formatCurrency(widget.contract.price!) : 'Không xác định'}đ/tháng',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 3),

                    Text(
                      'Tiền cọc: ${widget.contract.deposit != null ? formatCurrency(widget.contract.deposit!) : 'Không xác định'}đ',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 3),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          width: MediaQuery.of(context).size.width * 0.21,
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
                            width: MediaQuery.of(context).size.width * 0.20,
                            backgroundColor: Colors.green,
                            text: 'Hóa đơn',
                            onPressed: () => print('t'),
                          ),
                        if (widget.contract.status == "Active")
                        ActionButton(
                            width: MediaQuery.of(context).size.width * 0.20,
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


}
