import '../../utils/calendar_utils.dart';
import 'package:date_format/date_format.dart';

extension MyDateTime on DateTime {
  String toTitle() {
    return "$year年$month月";
  }

  int countPageDifference(DateTime currentDateTime) {
    int jumpPage = (year - currentDateTime.year) * 12 +
        (month - currentDateTime.month);
    int currentPage = (currentDateTime.year - kFirstDay.year) * 12 +
        (currentDateTime.month - kFirstDay.month);

    jumpPage = jumpPage + currentPage;
    return jumpPage;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  String formatToTW() {
    return formatDate(this, [yyyy, '年', mm, '月', dd , '日 ' , D], locale: const SimplifiedChineseDateLocale() );
  }

  String listFormat() {
    return formatDate(this, [mm, '月', dd , '日 ' , D], locale: const SimplifiedChineseDateLocale() );
  }

  bool isEqualTo(DateTime dateTime) {
    if(this.year == dateTime.year && this.month == dateTime.month && this.day == dateTime.day) {
      return true;
    }

    return false;
  }
}