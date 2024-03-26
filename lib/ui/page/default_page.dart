import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/route/route_data.dart';
import 'package:account_book/route/transition_enum.dart';
import 'package:account_book/ui/bloc/default_page_bloc.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/model/bottom_navigation_model.dart';
import 'package:account_book/ui/widget/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class DefaultPage extends StatefulWidget {
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  late DefaultPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DefaultPageBloc>(context);
    ApplicationBloc.getInstance().getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    return StreamBuilder<RouteData>(
        stream: ApplicationBloc.getInstance().subPageStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          var routeData = snapshot.requireData;

          return SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: _buildBottomNavigationBar(routeData),
                body: Container(
                  child: _contentPage(routeData),
                )),
          );
        });
  }

  Widget _contentPage(RouteData routeData) {
    return Builder(builder: (context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SizedBox.expand(
            child: bloc.getPage(routeData),
          ));
    });
  }

  Widget _buildBottomNavigationBar(RouteData routeData) {
    return BottomNavigationWidget(
      currentRouteName: routeData.routeName,
      bottomNavigationList: bloc.bottomNavigationList,
      onTap: (BottomNavigationData data) {
        var url = '';
        switch (data.type) {
          case BottomNavigationEnum.AccountBook:
            url = PageName.AccountBookPage;
            break;
          case BottomNavigationEnum.Account:
            url = PageName.AccountPage;
            break;
          case BottomNavigationEnum.Store:
            url = PageName.StorePage;
            break;
          case BottomNavigationEnum.Analyze:
            url = PageName.AnalyzePage;
            break;
          case BottomNavigationEnum.Setting:
            url = PageName.SettingPage;
            break;
        }
        if (url.isNotEmpty) {
          if (url != PageName.StorePage) {
            bloc.setSubPage(url);
          } else {
            bloc.pushPage(
              url,
              context,
              transitionEnum: TransitionEnum.BottomTop,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
