import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/models/transaction.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';

class UserTransactionScreen extends StatefulWidget {
  @override
  _UserTransactionScreenState createState() => _UserTransactionScreenState();
}

class _UserTransactionScreenState extends State<UserTransactionScreen> {
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  Transaction? _selectedTransaction;
  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.userInfo?.id != null) {
        final response = await ApiService().getListTransactionByUserId(authProvider.userInfo!.id!);
        if (response['status'] == 'SUCCESS') {
          setState(() {
            _transactions = (response['data'] as List)
                .map((json) => Transaction.fromJson(json))
                .toList()
              ..sort((a, b) => b.id!.compareTo(a.id!));
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      print('Error fetching transactions: $error');
      setState(() => _isLoading = false);
    }
  }

  Widget _buildTransactionTypeChip(int type) {
    String label;
    Color color;
    IconData icon;

    switch (type) {
      case 1:
        label = 'Nạp tiền';
        color = Colors.green;
        icon = Icons.add_circle_outline;
        break;
      case 2:
        label = 'Rút tiền';
        color = Colors.red;
        icon = Icons.remove_circle_outline;
        break;
      case 3:
        label = 'Thanh toán';
        color = Colors.orange;
        icon = Icons.payment;
        break;
      case 4:
        label = 'Hoàn tiền';
        color = Colors.blue;
        icon = Icons.replay;
        break;
      default:
        label = 'Khác';
        color = Colors.grey;
        icon = Icons.more_horiz;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(int status) {
    String label;
    Color color;
    IconData icon;

    switch (status) {
      case 1:
        label = 'Thành công';
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case 2:
        label = 'Thất bại';
        color = Colors.red;
        icon = Icons.error_outline;
        break;
      default:
        label = 'Đang xử lý';
        color = Colors.orange;
        icon = Icons.hourglass_empty;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {Widget? trailing}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: trailing ?? Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Giao dịch')),
        body: Center(child: CircularProgressIndicator()),
      );
    }



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Giao dịch'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Số dư hiện tại: ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                Text(
                  currencyFormatter.format(authProvider.userInfo?.balance ?? 0),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: Icon(Icons.add),
                //   label: Text('Nạp tiền'),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     foregroundColor: Theme.of(context).primaryColor,
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Lịch sử giao dịch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => _showTransactionDetails(transaction),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTransactionTypeChip(transaction.type!),
                              _buildStatusChip(transaction.status!),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            currencyFormatter.format(transaction.amount),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            DateFormat('dd/MM/yyyy HH:mm')
                                .format(transaction.createdAt!),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  void _showTransactionDetails(Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chi tiết giao dịch'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Mã giao dịch:', '${transaction.id}'),
              _detailRow('Thời gian:',
                  DateFormat('dd/MM/yyyy HH:mm').format(transaction.createdAt!)),
              _detailRow('Loại giao dịch:', '',
                  trailing: _buildTransactionTypeChip(transaction.type!)),
              _detailRow('Số tiền:', currencyFormatter.format(transaction.amount)),
              _detailRow('Số dư trước GD:',
                  currencyFormatter.format(transaction.balanceBefore)),
              _detailRow('Số dư sau GD:',
                  currencyFormatter.format(transaction.balanceAfter)),
              _detailRow('Mô tả:', transaction.description ?? ''),
              _detailRow('Trạng thái:', '',
                  trailing: _buildStatusChip(transaction.status!)),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Đóng'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

}