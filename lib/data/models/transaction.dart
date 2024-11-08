class Transaction {
  final int? id;
  final int? type;
  final int? status;
  final double? amount;
  final double? balanceBefore;
  final double? balanceAfter;
  final String? description;
  final DateTime? createdAt;
  final int? paymentMethod;
  final int? userId;
  final String? no;

  Transaction({
    this.id,
    this.type,
    this.status,
    this.amount,
    this.balanceBefore,
    this.balanceAfter,
    this.description,
    this.createdAt,
    this.paymentMethod,
    this.userId,
    this.no,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 12,
      type: json['transaction_type'] ?? 1,
      status: json['status'] ?? 1,
      amount: (json['amount'] != null ? json['amount'].toDouble() : 1500.0),
      balanceBefore: (json['balance_before'] != null ? json['balance_before'].toDouble() : 7500.0),
      balanceAfter: (json['balance_after'] != null ? json['balance_after'].toDouble() : 9000.0),
      description: json['description'] ?? 'Payment for services',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.parse('2024-10-25T05:20:35.155646Z')
          : DateTime.parse('2024-10-25T05:20:35.155646Z'),
      paymentMethod: json['payment_method'] ?? 0,
      userId: json['user_id'] ?? 1,
      no: json['transaction_no'] ?? '5',
    );
  }

}