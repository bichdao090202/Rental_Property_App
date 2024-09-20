import 'package:flutter/material.dart';
import 'package:rental_property_app/models/contract.dart';

class ContractDialog extends StatelessWidget {
  final Contract contract;

  const ContractDialog({Key? key, required this.contract}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Chiều ngang 90%
        height: MediaQuery.of(context).size.height * 0.9, // Chiều dọc tối đa 90%
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                contract.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Text(contract.content),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(), // Nút đóng
                  child: Text('Đóng'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

