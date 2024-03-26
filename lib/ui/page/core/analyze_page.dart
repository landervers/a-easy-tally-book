import 'dart:core';

import 'dart:convert';
import 'package:account_book/tools/app_colors.dart';
import 'package:account_book/ui/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import '../../model/amount_data.dart';




List<AmountCategory> amountCategoryList = [
  AmountCategory(iconData: Icons.restaurant, categoryName: "用餐"),
  AmountCategory(iconData: Icons.book, categoryName: "学习"),
  AmountCategory(iconData: Icons.train, categoryName: "交通"),
  AmountCategory(iconData: Icons.shopping_bag, categoryName: "日用品"),
  AmountCategory(iconData: Icons.water_drop, categoryName: "水电费"),
  AmountCategory(iconData: Icons.phone_android, categoryName: "话费"),
  AmountCategory(iconData: Icons.home, categoryName: "家用"),
  AmountCategory(iconData: Icons.shop, categoryName: "服装"),
  AmountCategory(iconData: Icons.car_crash_sharp, categoryName: "汽车"),
  AmountCategory(iconData: Icons.local_hospital, categoryName: "医疗"),
  AmountCategory(iconData: Icons.sunny, categoryName: "娱乐"),
  AmountCategory(iconData: Icons.pets, categoryName: "宠物"),
];


List<Color> colorList = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.indigo,
  Colors.cyan,
];




class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {


  int touchedIndex = -1;
  List<Indicator> buildIndicators() {
    List<Indicator> indicators = [];
    for (int i = 0; i < mymap.length; i++) {
      indicators.add(
        Indicator(
          color: colorList[i % colorList.length],
          text: amountCategoryList[mymap[i].key].categoryName,
          isSquare: true,
        ),
      );
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    List<Indicator> indicators = buildIndicators();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "消费组成",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                /// 动态生成图例
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: indicators,
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }


  List<PieChartSectionData> showingSections() {
    return List.generate(mymap.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];



      ///pie的属性
      return PieChartSectionData(
        color: colorList[i % colorList.length],
        value: mymap[i].value,
        title: amountCategoryList[mymap[i].key].categoryName,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: shadows,
        ),
      );

      //   case 1:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorYellow,
      //       value: 30,
      //       title: '30%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorPurple,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorGreen,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   default:
      //     throw Error();
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  late List<MapEntry<int, double>> mymap = [] ;

  void initData () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? amountDatasString = await prefs.getString('amount_datas');
    final List<AmountData> xx = AmountData.decode(amountDatasString!);
    Map<int, double> categoryAmountMap = {};

// 遍历列表，将相同 categoryIndex 的 amount 累加起来
    xx.forEach((data) {
      categoryAmountMap.update(data.categoryIndex, (value) => value + data.amount.toDouble(), ifAbsent: () => data.amount.toDouble());
    });

// 创建新的列表，仅包含 categoryIndex 和对应的 amount，amount 类型为 double
    List<MapEntry<int, double>> newlist= categoryAmountMap.entries.map((entry) => MapEntry(entry.key, entry.value)).toList();



    setState(() {
      mymap = newlist;
    });

  }
}

