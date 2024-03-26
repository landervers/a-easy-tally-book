import 'package:flutter/material.dart';

class MyDividerWidget extends StatelessWidget {
  final double? height;
  const MyDividerWidget({Key? key, this.height = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
    );
  }
}
