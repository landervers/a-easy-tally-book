import 'package:account_book/extension/datetime_extension.dart';
import 'package:account_book/ui/bloc/core/account_book_page_bloc.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/model/amount_data.dart';
import 'package:account_book/ui/widget/date_title_widget.dart';
import 'package:account_book/ui/widget/list_tile/amount_list_tile_widget.dart';
import 'package:account_book/ui/widget/my_divider_widget.dart';
import 'package:account_book/ui/widget/no_feedback_ink_widget.dart';
import 'package:account_book/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class AccountListPage extends StatefulWidget {
  final AccountBookPageBloc bloc;

  const AccountListPage({Key? key, required this.bloc}) : super(key: key);

  @override
  State<AccountListPage> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  List<AmountData> amountDataList = [];
  late DateTime currentDate;

  int currentDataIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
        stream: ApplicationBloc.getInstance().dateDataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          }
          var focusDay = snapshot.requireData;
          amountDataList = sortData(focusDay);
          return Column(
            children: [
              _buildTitle(focusDay),
              Expanded(child: _buildListView(focusDay)),
            ],
          );
        });
  }

  Widget _buildListView(DateTime focusDay) {
    currentDate = DateTime(kToday.year - 20, kToday.month, kToday.day);
    bool dayStart = true;
    bool dayEnd = false;
    int amount = 0;
    if (amountDataList.isEmpty) {
      return ListTile(
        visualDensity: VisualDensity(vertical: -4),
        leading: Text(
          "暂无记录，按“+”新增",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
      );
    }
    return ListView.separated(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: amountDataList.length + 1,
        separatorBuilder: (context, index) {
          return MyDividerWidget();
        },
        itemBuilder: (context, index) {
          if (index == 0 && amountDataList.isNotEmpty) {
            return Container(
              color: Theme.of(context).colorScheme.onBackground,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNumWidget(AmountType.Income),
                    _buildNumWidget(AmountType.Expenditure),
                    _buildNumWidget(AmountType.Total),
                  ],
                ),
              ),
            );
          }
          if (currentDate == amountDataList[index - 1].date) {
            dayStart = false;
          } else {
            amount = 0;
            dayStart = true;
          }
          amount += amountDataList[index - 1].amount;
          currentDate = amountDataList[index - 1].date;
          if (index != amountDataList.length) {
            if (amountDataList[index].date != currentDate) {
              dayEnd = true;
            } else {
              dayEnd = false;
            }
          } else {
            dayEnd = true;
          }

          return Column(
            children: [
              if (dayStart)
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(vertical: -3),
                  leading: Text(
                    currentDate.listFormat().toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              AmountListTileWidget(
                  onCopyTap: () {
                    widget.bloc.openStorePage(
                        context, amountDataList[index - 1], true);
                  },
                  onEditTap: () {
                    widget.bloc.openStorePage(
                        context, amountDataList[index - 1], false);
                  },
                  amountData: amountDataList[index - 1]),
              if (dayEnd) MyDividerWidget(),
              if (dayEnd)
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4),
                    trailing: Text(
                      "支出: $amount",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
            ],
          );
        });
  }

  Widget _buildTitle(DateTime focusDay) {
    return Column(
      children: [
        ListTile(
          tileColor: Theme.of(context).colorScheme.onBackground,
          leading: NoFeedbackInkWellWidget(
            onTap: () {
              widget.bloc.pageChanged(
                  DateTime(focusDay.year, focusDay.month - 1, focusDay.day));
            },
            iconData: Icons.arrow_back_ios_new_sharp,
          ),
          title: DateTitleWidget(
              focusDay: focusDay,
              onConfirm: (date) {
                widget.bloc.pageChanged(date);
              }),
          trailing: NoFeedbackInkWellWidget(
            onTap: () {
              widget.bloc.pageChanged(
                  DateTime(focusDay.year, focusDay.month + 1, focusDay.day));
            },
            iconData: Icons.arrow_forward_ios_sharp,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          visualDensity: VisualDensity(vertical: -3), // to compact
        ),
      ],
    );
  }

  Widget _buildNumWidget(AmountType amountType) {
    Widget numText;
    String text = "";
    int amount = 0;
    for (var element in amountDataList) {
      amount += element.amount;
    }
    switch (amountType) {
      case AmountType.Income:
        numText = Text(
          "0",
          style: TextStyle(color: Colors.green, fontSize: 20),
        );
        text = "收入";
        break;
      case AmountType.Expenditure:
        numText = Text(
          "$amount",
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
        text = "支出";
        break;
      case AmountType.Total:
        int total = -amount + 0;

        numText = total < 0
            ? Text("$total", style: TextStyle(color: Colors.red, fontSize: 20))
            : Text("$total",
                style: TextStyle(color: Colors.green, fontSize: 20));
        text = "合計";
        break;
    }

    return Column(
      children: [
        numText,
        Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }

  int countDays(DateTime focusDay) {
    var amountDataList = filterMonth(focusDay);
    amountDataList.sort((b, a) {
      return a.date.compareTo(b.date);
    });

    Set<DateTime> days = {};

    amountDataList.forEach((element) {
      days.add(element.date);
    });
    return days.length;
  }

  List<AmountData> filterMonth(DateTime date) {
    List<AmountData> resultList = [];
    var amountDataList = ApplicationBloc.getInstance().amountDataList;
    amountDataList.forEach((element) {
      if (element.date.year == date.year && element.date.month == date.month) {
        resultList.add(element);
      }
    });
    return resultList;
  }

  List<AmountData> sortData(DateTime focusDay) {
    var amountDataList = filterMonth(focusDay);
    amountDataList.sort((b, a) {
      return a.date.compareTo(b.date);
    });
    return amountDataList.toList();
  }
}
