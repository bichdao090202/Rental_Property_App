import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/widgets/custom/pdf_viewer_dialog.dart';

class ContractDialog extends StatelessWidget {
  final Contract contract;

  const ContractDialog({Key? key, required this.contract}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                contract.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Text(contract.content),
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: ElevatedButton(
            //       onPressed: () {
            //         if (contract.pdfPath.isNotEmpty) {
            //           showDialog(
            //             context: context,
            //             builder: (context) => PdfViewerDialog(pdfFile: contract.pdfPath),
            //           );
            //         } else {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(content: Text('Không tìm thấy file PDF cho hợp đồng này.')),
            //           );
            //         }
            //       },
            //       child: Text('Xem hợp đồng PDF'),
            //       style: ElevatedButton.styleFrom(
            //         foregroundColor: Colors.white, backgroundColor: Colors.blue,
            //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đóng'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

