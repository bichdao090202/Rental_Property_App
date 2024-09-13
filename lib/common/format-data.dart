import 'package:intl/intl.dart';

String formatCurrency(double price) {
  return NumberFormat('#,###', 'vi_VN').format(price);
}