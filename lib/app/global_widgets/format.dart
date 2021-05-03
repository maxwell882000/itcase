import 'package:intl/intl.dart';


class Format{
 static  final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
 static  final inputFormatWithoutHours = DateFormat('yyyy-MM-dd');
 static  final outputFormat = DateFormat('dd.MM.yyyy HH:mm');
  static final outputFormatDeadline = DateFormat('dd.MM.yyyy');
 static final outputFormatLastSeen = DateFormat('MMMEd HH:mm');
 static final outputFormatMessages = DateFormat("HH:mm");
 static parseDate(String input, DateFormat output) {
    DateTime before = DateTime.parse(input);
    return output.format(before);
  }
  // static void parseDateStandart({String input}){
  //   DateTime before = DateTime.parse(input);
  //   return outp
  // }
  static compareDates(String first, String second) {
    DateTime firstDate = DateTime.parse(first);
    DateTime secondDate = DateTime.parse(second);
    bool returning = firstDate.isAfter(secondDate);
    return !returning;
  }
}