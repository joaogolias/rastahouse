import 'package:intl/intl.dart';

class TaskWeek {
  TaskWeek(this.startTime, this.endTime);

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

  String get duration {
    return '$startTimeString - $endTimeString';
  }
}
