import 'package:intl/intl.dart';

class DateFormatterUtils {
  static String formatDateFromString(String? stringDate) {
    if(stringDate!=null){
      final date = DateTime.tryParse(stringDate) ?? DateTime.now();
      final formatter = DateFormat('MMM, d, y');
      return formatter.format(date);
    }
    return "null";
  }
}
