class BorrowItem {
  final int id;
  final String name;
  final double price;

  BorrowItem({
    required this.id,
    required this.name,
    required this.price,
  });

  factory BorrowItem.fromJson(Map<String, dynamic> json) {
    return BorrowItem(
      id: json['id']??0,
      name: json['name']??'',
      price : (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as num).toDouble()
    );
  }

  @override
  String toString() {
    return 'BorrowItem{id: $id, name: $name, price: $price}';
  }

}