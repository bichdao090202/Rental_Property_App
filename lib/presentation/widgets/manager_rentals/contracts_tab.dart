import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/widgets/card/contract_card.dart';
class ContractsTab extends StatelessWidget {
  final int userId;
  final String type;

  const ContractsTab({super.key, required this.userId, required this.type});

  Future<List<Contract>> _fetchContracts() async {
    final responseData;
    if (type == "renter") {
      responseData = await ApiService().getContractByRenterId(userId);
    } else {
      responseData = await ApiService().getContractByLessorId(userId);
    }

    final List<dynamic> contractsList = responseData['data'] ?? [];
    List<Contract> list = contractsList.map((roomData) => Contract.fromJson(roomData)).toList();
    list.sort((a, b) => b.id.compareTo(a.id));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contract>>(
      future: _fetchContracts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có hợp đồng nào'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final contract = snapshot.data![index];
            return ContractCard(
              contract: contract,
              type: type,
              userId: userId,
            );
          },
        );
      },
    );
  }
}