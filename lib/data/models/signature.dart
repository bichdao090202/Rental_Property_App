class Signature {
  final int id;
  final String serviceType;
  final String cccdNumber;

  Signature({
    required this.id,
    required this.serviceType,
    required this.cccdNumber,
  });

  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
      id: json['id'] as int? ?? 0,
      serviceType: json['service_type'] as String? ?? '',
      cccdNumber: json['cccd_number'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_type': serviceType,
      'cccd_number': cccdNumber,
    };
  }
}