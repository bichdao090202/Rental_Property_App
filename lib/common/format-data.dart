import 'package:intl/intl.dart';

String formatCurrency(double price) {
  return NumberFormat('#,###', 'vi_VN').format(price);
}

String formatDay(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String formatDatetime(DateTime datetime) {
  return DateFormat('dd-MM-yyyy HH:mm:ss').format(datetime);
}