import 'package:account_book/extension/datetime_extension.dart';
import 'package:account_book/tools/colors.dart';
import 'package:account_book/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class DateTitleWidget extends StatelessWidget {
  final Function(DateTime)? onConfirm;

  final DateTime focusDay;

  const DateTitleWidget({
    Key? key,
    this.onConfirm,
    required this.focusDay
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(context, onConfirm, focusDay);
      },
      highlightColor: Colors.black,
      splashFactory: NoSplash.splashFactory,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            focusDay.toTitle(),
            style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.primary),
          ),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }

  void showDatePicker(BuildContext context, Function(DateTime)? onConfirm, DateTime focusDay) {
    DatePicker.showDatePicker(
      context,
      minTime: kFirstDay,
      maxTime: kLastDay,
      locale: LocaleType.zh,
      currentTime: focusDay,
      // theme: DatePickerTheme(
      //   backgroundColor: lightBlack,
      //   itemStyle: TextStyle(color: Colors.white),
      //   cancelStyle: TextStyle(color: Colors.blue),
      //   doneStyle: TextStyle(color: Colors.blue, fontSize: 18),
      // ),
      onConfirm: (date) {
        if (onConfirm != null) {
          onConfirm(date);
        }
      },
    );
  }

}
