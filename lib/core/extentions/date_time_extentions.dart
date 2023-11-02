import 'package:intl/intl.dart';

extension DateTimeExtentions on DateTime {
  String get ddMMyyyyHHmmss => DateFormat('dd.MM.yyyy HH:mm:ss').format(this);
}
