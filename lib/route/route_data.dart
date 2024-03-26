class RouteData {
  /// 路由名稱
  String routeName;

  /// 傳入參數
  Map<String, dynamic> blocQuery;

  /// 是否加入歷史紀錄
  bool addHistory;

  RouteData(
      this.routeName, {
        this.blocQuery = const {},
        this.addHistory = true,
      });
}