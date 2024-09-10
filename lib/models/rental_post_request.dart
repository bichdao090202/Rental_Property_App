class RentalPostRequest {
  final String title;
  final String description;
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String price;
  final String type;
  final String status;
  final String userId;
  final String imageUrl;

  RentalPostRequest({
    required this.title,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.price,
    required this.type,
    required this.status,
    required this.userId,
    required this.imageUrl,
  });

  factory RentalPostRequest.fromJson(Map<String, dynamic> json) {
    return RentalPostRequest(
      title: json['title'],
      description: json['description'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      price: json['price'],
      type: json['type'],
      status: json['status'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'price': price,
      'type': type,
      'status': status,
      'userId': userId,
      'imageUrl': imageUrl,
    };
  }
}