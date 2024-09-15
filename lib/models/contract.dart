class Contract {
  int id;
  int? renterId;
  int landlordId;
  int? propertyId;
  String name;
  String content;
  DateTime? dateRent;
  DateTime? datePay;

  Contract({required this.id, required this.name, required this.content, required this.landlordId});
}