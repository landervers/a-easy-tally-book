import 'package:flutter/material.dart';

class MaterialInkWidget extends StatelessWidget {
  const MaterialInkWidget({
    required this.child,
    this.onTap,
    this.splashColor,
    this.backgroundColor,
  });

  /// 點擊事件
  final GestureTapCallback? onTap;

  /// 水波紋顏色
  final Color? splashColor;

  /// 背景色
  final Color? backgroundColor;

  /// 顯示元件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Material(
        key: key,
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
