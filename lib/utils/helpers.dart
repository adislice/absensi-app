

import 'package:intl/intl.dart';

class Helpers {
  // function to format date from string "yyyy-MM-dd" to "Selasa, 20 Juni 2023". the parameter is string
  static String formatDate(String date) {
    return DateFormat('EEEE, d MMMM yyyy', 'id').format(DateTime.parse(date));
  }

}