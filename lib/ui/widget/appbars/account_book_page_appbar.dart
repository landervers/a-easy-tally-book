import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/ui/bloc/core/account_book_page_bloc.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/widget/common_app_bar_widget.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class AccountBookPageAppBar extends StatefulWidget {
  // final AccountBookPageBloc bloc;
  const AccountBookPageAppBar({
    Key? key,
    // required this.bloc
  }) : super(key: key);

  @override
  State<AccountBookPageAppBar> createState() => _AccountBookPageAppBarState();
}

class _AccountBookPageAppBarState extends State<AccountBookPageAppBar> {
  late AccountBookPageBloc bloc;
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AccountBookPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppBarWidget(
      title: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.white))),
          Center(
            child: SizedBox(
              height: 30,
              child: _topToggleButton(context),
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    ApplicationBloc.getInstance().deleteAllData();
                  },
                  icon: const Icon(Icons.delete, color: Colors.black))),
        ],
      ),
    );
  }

  Widget _topToggleButton(BuildContext context) {
    int selectedIndex = 0;
    return ToggleButtons(
      color: Theme.of(context).colorScheme.primary,
      borderColor: Colors.white,
      fillColor: Colors.white,
      selectedColor: Theme.of(context).colorScheme.tertiary,
      selectedBorderColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderWidth: 1,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: Text(
            "日期",
            style: isSelected[0]
                ? Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white),
          )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Center(
              child: Text(
            "总账单",
            style: isSelected[1]
                ? Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary)
                : Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white),
          )),
        ),
      ],
      onPressed: (int index) {
        selectedIndex = isSelected.indexWhere((element) => element == true);
        setState(() {
          if (selectedIndex != index) {
            isSelected[selectedIndex] = false;
            isSelected[index] = true;
            bloc.pageController.animateToPage(index,
                duration: Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn);
          }
        });
      },
      isSelected: isSelected,
    );
  }
}
