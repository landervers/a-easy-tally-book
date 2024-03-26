import 'package:account_book/extension/datetime_extension.dart';
import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/route/transition_enum.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/model/amount_data.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AccountBookPageBloc extends PageBloc {
  AccountBookPageBloc(BlocOption blocOption) : super(blocOption);

  PageController pageController = PageController();

  late PageController calendarPageController;

  final CalendarFormat calendarFormat = CalendarFormat.month;

  int focusDayExpenditure = 0;

  final appBloc = ApplicationBloc.getInstance();

  void pickDay(DateTime date, DateTime focusDay) {
    calendarPageController.jumpToPage(
      date.countPageDifference(focusDay),
    );
    appBloc.setDate(date);
  }

  void pageChanged(DateTime focusDay) {
    appBloc.setDate(focusDay.copyWith(
        day: appBloc.dateDataSubject.value.day));
  }

  void daySelected(DateTime selectedDay) {
    appBloc.setDate(selectedDay);
  }

  void openStorePage(BuildContext context, AmountData amountData, bool isCopy) {
    var blocQuery = AmountData.toMap(amountData);
    blocQuery['isCopy'] = isCopy;
    pushPage(PageName.StorePage, context,
        transitionEnum: TransitionEnum.BottomTop,
        blocQuery: {BlocOptionKey.StoringAmountDataKey: blocQuery});
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class DateData {
  DateTime focusedDay = DateUtils.dateOnly(DateTime.now());
  DateTime selectedMonth = DateUtils.dateOnly(DateTime.now());
}
