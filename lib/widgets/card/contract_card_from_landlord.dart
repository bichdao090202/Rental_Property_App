import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/widgets/custom/contract_dialog.dart';

class ContractCardFromLandlord extends StatelessWidget {
  final Contract contract;

  const ContractCardFromLandlord({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contract.name),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ContractDialog(contract: contract),
          );
        },
      ),
    );
  }
}

