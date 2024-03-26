import 'package:flutter/material.dart';

class CommonAppBarWidget extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CommonAppBarWidget({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: title,
      leading: leading,
      actions: actions,
      bottom: bottom,
      shape: Border(
          bottom: BorderSide(
              color: Colors.white12,
              width: 1
          )
      ),
    );
  }
}
