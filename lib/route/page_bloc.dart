import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/transition_enum.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:flutter/material.dart';
import 'route_data.dart';

class PageBloc implements BaseBloc{
  @override
  late BlocOption option;

  PageBloc(BlocOption blocOption) {
    option = blocOption;
  }

  Widget getPage(RouteData routeData) {
    return ApplicationBloc.getInstance().getPage(routeData.routeName, blocQuery: routeData.blocQuery);
  }

  /// 子页面
  void setSubPage(
    String route, {
    Map<String, dynamic> blocQuery = const {},
    bool addHistory = true,
  }) {
    ApplicationBloc.getInstance().addSubPageRoute(RouteData(
      route,
      blocQuery: blocQuery,
      addHistory: addHistory,
    ));
  }

  void popSubPage() {
    ApplicationBloc.getInstance().popSubPage();
  }


  void pushPage(
      String route,
      BuildContext context, {
      bool replaceCurrent = false,
      Map<String, dynamic> blocQuery = const {},
      TransitionEnum transitionEnum = TransitionEnum.Normal,
  }) {
    ApplicationBloc.getInstance().pushPage(
        route,
        context,
        blocQuery: blocQuery,
        transitionEnum: transitionEnum
    );
  }


  @override
  void dispose() {

  }



}

