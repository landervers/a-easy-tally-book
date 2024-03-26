// ignore_for_file: prefer_const_constructors

import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/ui/bloc/core/account_book_page_bloc.dart';
import 'package:account_book/ui/page/account_calendar_page.dart';
import 'package:account_book/ui/page/account_list_page.dart';
import 'package:account_book/ui/widget/appbars/account_book_page_appbar.dart';
import 'package:flutter/material.dart';

class AccountBookPage extends StatefulWidget {
  const AccountBookPage({Key? key}) : super(key: key);

  @override
  State<AccountBookPage> createState() => _AccountBookPageState();
}

class _AccountBookPageState extends State<AccountBookPage> {
  late AccountBookPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AccountBookPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountBookPageAppBar(),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: bloc.pageController,
            children: [
              AccountCalendarPage(bloc: bloc),
              AccountListPage(bloc: bloc),
            ],
          ),
        ),
      ],
    );
  }
}
