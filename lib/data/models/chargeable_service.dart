import 'package:rental_property_app/common/format-data.dart';

class ChargeableService {
  final String serviceName;
  final int quantity;
  final double unitPrice;
  final String unitOfMeasurement;

  ChargeableService({
    required this.serviceName,
    required this.quantity,
    required this.unitPrice,
    required this.unitOfMeasurement
  });

  String getService() {
    return '$serviceName (${formatCurrency(unitPrice)}đ/$unitOfMeasurement)';
  }
}