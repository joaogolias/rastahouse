import 'package:intl/intl.dart';

class TaskWeek {
  TaskWeek(DateTime startTime, DateTime endTime) {
    this.startTime = startTime;
    this.endTime = endTime;
  }
  DateTime startTime;
  DateTime endTime;

  String get startTimeString {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this.startTime);
  }

  String get endTimeString {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this.endTime);
  }
}
