import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rental_property_app/common/api.dart';
import 'package:rental_property_app/models/contract.dart';
import 'package:rental_property_app/widgets/card/contract_card_from_landlord.dart';

import 'package:rental_property_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:rental_property_app/widgets/card/contract_card_from_renter.dart';
import 'package:rental_property_app/widgets/custom/file_picker_pdf_dialog.dart';

class ContractTabFromLandlord extends StatefulWidget {
  @override
  _ContractTabFromLandlordState createState() => _ContractTabFromLandlordState();
}

class _ContractTabFromLandlordState extends State<ContractTabFromLandlord> {
  void _createContract() async {
    String? fileContent;
    TextEditingController _nameController = TextEditingController();
    File? _file;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tạo hợp đồng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên hợp đồng'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text('Chọn file'),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx'],
                  );

                  if (result != null && result.files.single.path != null) {
                    fileContent = 'Nội dung từ file';
                    print('Chọn file: ${result.files.single.name}');
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && fileContent != null) {
                  setState(() {
                    contracts.add(
                      Contract(
                        id: contracts.length + 1,
                        name: _nameController.text,
                        content: fileContent!,
                        landlordId: 1,
                        pdfPath: 'assets/hop-dong-thue-nha-o_2810144434_2011152916_0804150405.pdf',
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tạo'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignature(String base64File) async {
    try {
      final response = await signPdfDocument(base64File);
      // Xử lý response ở đây
    } catch (e) {
      // Xử lý lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách hợp đồng'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
              onPressed: () {
                FilePickerDialog.show(context);
              },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: contracts.where((contract) => contract.renterId != null).length,
          itemBuilder: (context, index) {
            final contract = contracts.where((contract) => contract.renterId != null).elementAt(index);
            return ContractCardFromRenter(contract: contract);
          }
      ),
    );
  }
}

