import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/route/transition_enum.dart';
import 'package:account_book/ui/bloc/choose_Category_page_bloc.dart';
import 'package:account_book/ui/bloc/core/account_book_page_bloc.dart';
import 'package:account_book/ui/bloc/core/analyze_page_bloc.dart';
import 'package:account_book/ui/bloc/core/setting_page_bloc.dart';
import 'package:account_book/ui/bloc/core/store_page_bloc.dart';
import 'package:account_book/ui/bloc/default_page_bloc.dart';
import 'package:account_book/ui/page/choose_category_page.dart';
import 'package:account_book/ui/page/core/account_book_page.dart';
import 'package:account_book/ui/page/core/analyze_page.dart';
import 'package:account_book/ui/page/core/setting_page.dart';
import 'package:account_book/ui/page/core/store_page.dart';
import 'package:account_book/ui/page/default_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

mixin RouteMixin {

  Future<T?> pushPage<T>(
      String routeName,
      BuildContext context, {
        Map<String, dynamic> blocQuery = const {},
        TransitionEnum transitionEnum = TransitionEnum.Normal,
        bool pushAndReplace = false,
        PageRoute<T>? pageRoute,
      }) async {
    var navigator = Navigator.of(context);
    var pageWidget = _getPage(routeName, blocQuery);

    pageRoute ??= MaterialPageRoute<T>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => pageWidget,
    );

    var bottomToTopRoute = PageTransition(
      settings: RouteSettings(name: routeName),
      type: PageTransitionType.bottomToTop,
      child: pageWidget,
      duration: Duration(milliseconds: 350)
    );

    var rightLeftRoute = PageTransition(
      settings: RouteSettings(name: routeName),
      type: PageTransitionType.rightToLeft,
      child: pageWidget,
    );

    switch(transitionEnum) {
      case TransitionEnum.Normal:
        if (pushAndReplace) {
          return navigator.pushReplacement(pageRoute);
        } else {
          return navigator.push(pageRoute);
        }
      case TransitionEnum.BottomTop:
        Navigator.push(context, bottomToTopRoute);
        break;
      case TransitionEnum.RightLeft:
        Navigator.push(context, rightLeftRoute);
        break;
      default:
        throw "Transition fail";
    }

  }


  /// 取得特定页面Widget
  Widget getPage(
    String route, {
    Map<String, dynamic> blocQuery = const {},
  }) {
    return _getPage(route, blocQuery);
  }

  Widget _getPage(String routeName, Map<String, dynamic> query) {
    switch(routeName){
      case PageName.DefaultPage:
        return BlocProvider(
            bloc: DefaultPageBloc(BlocOption(query)),
            child: DefaultPage()
        );
      case PageName.AccountBookPage:
        return BlocProvider(
            bloc: AccountBookPageBloc(BlocOption(query)),
            child: AccountBookPage()
        );
      case PageName.StorePage:
        return BlocProvider(
            bloc: StorePageBloc(BlocOption(query)),
            child: StorePage()
        );
      case PageName.AnalyzePage:
        return BlocProvider(
            bloc: AnalyzePageBloc(BlocOption(query)),
            child: PieChartSample2()
        );
      case PageName.SettingPage:
        return BlocProvider(
            bloc: SettingPageBloc(BlocOption(query)),
            child: SettingPage()
        );
      case PageName.ChooseCategoryPage:
        return BlocProvider(
            bloc: ChooseCategoryPageBloc(BlocOption(query)),
            child: ChooseCategoryPage()
        );

      default:
        throw ("RouteMixin 无法找到对应Page");
    }
  }

}