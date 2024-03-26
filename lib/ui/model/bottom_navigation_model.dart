import 'package:flutter/cupertino.dart';

class BottomNavigationData {

  final BottomNavigationEnum type;

  final IconData icon;

  final String title;

  final String url;

  const BottomNavigationData({
    required this.type,
    required this.title,
    required this.icon,
    required this.url,
  });
}

enum BottomNavigationEnum {
  /// 账本
  AccountBook,

  /// 用户
  Account,

  /// 记账
  Store,

  /// 分析账本
  ///
  Analyze,

  /// 设置
  Setting,
}