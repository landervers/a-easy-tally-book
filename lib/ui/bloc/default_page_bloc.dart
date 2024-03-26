import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/ui/model/bottom_navigation_model.dart';
import 'package:flutter/material.dart';

class DefaultPageBloc extends PageBloc{
  DefaultPageBloc(BlocOption blocOption) : super(blocOption);

  final List<BottomNavigationData> bottomNavigationList = const [
    BottomNavigationData(
        type: BottomNavigationEnum.AccountBook,
        title: "记录",
        icon: Icons.edit,
        url: PageName.AccountBookPage
    ),
    BottomNavigationData(
        type: BottomNavigationEnum.Store,
        title: "记账",
        icon: Icons.add,
        url: PageName.StorePage
    ),
    BottomNavigationData(
        type: BottomNavigationEnum.Analyze,
        title: "账本分析",
        icon: Icons.pie_chart,
        url: PageName.AnalyzePage
    ),
    BottomNavigationData(
        type: BottomNavigationEnum.Setting,
        title: "设置",
        icon: Icons.settings,
        url: PageName.SettingPage
    ),

  ];

}