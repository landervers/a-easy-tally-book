import 'package:account_book/route/page_name.dart';
import 'package:account_book/route/route_data.dart';
import 'package:account_book/route/route_mixin.dart';
import 'package:account_book/ui/model/amount_data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';


final blankCategory = AmountCategory(iconData: Icons.error_outline, categoryName: "");
class ApplicationBloc with RouteMixin {

  static final _singleton = ApplicationBloc._internal();

  static ApplicationBloc getInstance() => _singleton;

  factory ApplicationBloc() => _singleton;

  ApplicationBloc._internal() {
    addSubPageRoute(RouteData(PageName.AccountBookPage));
  }

  /// 子页面记账记录
  List<RouteData> _subPageHistory = [];

  String? get lastSubPage => _subPageSubject.value.routeName;

  /// 记录当前子页面
  BehaviorSubject<RouteData> _subPageSubject = BehaviorSubject.seeded(RouteData(''));

  Stream<RouteData> get subPageStream => _subPageSubject.stream;

  /// 日期流
  BehaviorSubject<DateTime> dateDataSubject = BehaviorSubject.seeded(DateUtils.dateOnly(DateTime.now()));

  Stream<DateTime> get dateDataStream => dateDataSubject.stream.asBroadcastStream();

  /// 收支流
  BehaviorSubject<List<AmountData>> _amountDataSubject = BehaviorSubject.seeded([]);

  Stream<List<AmountData>> get amountDataStream => _amountDataSubject.stream.asBroadcastStream();

  List<AmountData> amountDataList = [];
///消费类型
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


  ///支付方式
  List<AmountCategory> PaidMethod = [
    AmountCategory(iconData: Icons.money, categoryName: "现金"),
    AmountCategory(iconData: Icons.phone_iphone, categoryName: "移动支付"),
    AmountCategory(iconData: Icons.credit_card, categoryName: "银行卡"),


  ];

///消费人
  List<AmountCategory> consumer = [
    AmountCategory(iconData: Icons.insert_emoticon_outlined, categoryName: "自己"),
    AmountCategory(iconData: Icons.family_restroom_outlined, categoryName: "家人"),
    AmountCategory(iconData: Icons.people_outline_sharp, categoryName: "朋友"),
    AmountCategory(iconData: Icons.man, categoryName: "同事"),
  ];
///消费体验
  List<AmountCategory> PaidMood= [
    AmountCategory(iconData: Icons.sentiment_satisfied_alt, categoryName: "满意"),
    AmountCategory(iconData: Icons.sentiment_dissatisfied_outlined, categoryName: "不满"),
    AmountCategory(iconData: Icons.sentiment_neutral, categoryName: "一般"),
  ];



  void setDate(DateTime date) {
    dateDataSubject.add(date);
  }

  void saveAmount(AmountData amountData) {
    bool isNotExist = amountDataList.where((element) => element.id == amountData.id).isEmpty;
    if(isNotExist){
      amountDataList.add(amountData);
    } else {
      int index = amountDataList.indexWhere((element) => element.id == amountData.id);
      amountDataList[index] = amountData;
    }
    _amountDataSubject.add(amountDataList);
    dateDataSubject.add(dateDataSubject.value);
    ApplicationBloc.getInstance().saveToSharedPreferences();
  }

  /// 加入历史记录
  void addSubPageRoute(RouteData routeData) {
    ///当前页面与routeData相同，则先移除当前页面历史记录
    /// 避免放回重复页面
    if (lastSubPage == routeData.routeName && _subPageHistory.isNotEmpty) {
      _subPageHistory.removeLast();
    }

    _subPageHistory.add(routeData);
    _subPageSubject.add(routeData);
  }

  void popSubPage() {
    if(_subPageHistory.length>1) {
      _subPageHistory.removeLast();
    }

    if(!_subPageHistory.last.addHistory) {
      _subPageHistory.removeLast();
    }

    _subPageSubject.add(_subPageHistory.last);
  }

  /// 关闭
  void dispose() {
    _subPageSubject.close();
  }

  void saveToSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = AmountData.encode(amountDataList);

    await prefs.setString('amount_datas', encodedData);
  }

  void getSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///保存数据
    final String? amountDatasString = await prefs.getString('amount_datas');
    if(amountDatasString != null) {
      final List<AmountData> amountDatas = AmountData.decode(amountDatasString);
      amountDataList = amountDatas;
    }
    _amountDataSubject.add(amountDataList);
  }

  void deleteAmountData(AmountData amountData) {
    print("delete");
    amountDataList.removeWhere((element) => element.id == amountData.id);
    _amountDataSubject.add(amountDataList);
    dateDataSubject.add(dateDataSubject.value);
    saveToSharedPreferences();
  }

  void deleteAllData() {
    amountDataList = [];
    _amountDataSubject.add(amountDataList);
    saveToSharedPreferences();
  }

}