import 'package:account_book/route/page_name.dart';
import 'package:account_book/tools/colors.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

void main() {
  runApp(
      EasyDynamicThemeWidget(
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  static ValueNotifier<MaterialColor> primaryColor = ValueNotifier<MaterialColor>(Colors.green);

  MyApp({Key? key}) : super(key: key);

  final themeData = ThemeData(
      // primarySwatch: Colors.orange,
      primaryColor: Colors.orange,
      secondaryHeaderColor: Colors.orange,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        )
      ),
      scaffoldBackgroundColor: lightBackground,
      iconTheme: IconThemeData(
        color: Colors.orange,
      ),
      dividerColor: Colors.grey,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black, fontSize: 25),
        bodyText2: TextStyle(color: Colors.black, fontSize: 22),
        subtitle1: TextStyle(color: Colors.black, fontSize: 20),
        subtitle2: TextStyle(color: Colors.black, fontSize: 18),
        headline1: TextStyle(color: Colors.grey, fontSize: 25),
        headline2: TextStyle(color: Colors.grey, fontSize: 22),
        headline3: TextStyle(color: Colors.grey, fontSize: 20),
        headline4: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.black,
        secondary: Colors.orange,
        tertiary: Colors.white,
        // brightness: Brightness.light,
        background: Colors.black12,
        surface: Colors.black12,
        primaryContainer: Colors.white,
        onBackground: lightSecond,
      ));

  final darkThemeData = ThemeData(
      primaryColor: lightBlack,
      secondaryHeaderColor: Colors.orange,
      scaffoldBackgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.orange,
      ),
      dividerColor: Colors.white38,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white, fontSize: 25),
        bodyText2: TextStyle(color: Colors.white, fontSize: 22),
        subtitle1: TextStyle(color: Colors.white, fontSize: 20),
        subtitle2: TextStyle(color: Colors.white, fontSize: 18),
        headline1: TextStyle(color: Colors.grey, fontSize: 25),
        headline2: TextStyle(color: Colors.grey, fontSize: 22),
        headline3: TextStyle(color: Colors.grey, fontSize: 20),
        headline4: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.white,
        secondary: Colors.black,
        tertiary: darkBackground,
        // brightness: Brightness.light,
        background: lightBlack,
        surface: Colors.grey,
        primaryContainer: Colors.white12,
        onBackground: darkBackground,
      ));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ValueListenableBuilder<MaterialColor>(
        valueListenable: primaryColor,
      builder: (_, MaterialColor primaryColor, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData.copyWith(primaryColor: primaryColor, secondaryHeaderColor: primaryColor, iconTheme: IconThemeData(color: primaryColor)),
          darkTheme: darkThemeData.copyWith(secondaryHeaderColor: primaryColor, iconTheme: IconThemeData(color: primaryColor)),
          themeMode: EasyDynamicTheme.of(context).themeMode,
          home: ApplicationBloc.getInstance().getPage(PageName.DefaultPage),
        );
      }
    );
  }
}
