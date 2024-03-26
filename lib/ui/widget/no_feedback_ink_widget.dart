import 'package:flutter/material.dart';

class NoFeedbackInkWellWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  const NoFeedbackInkWellWidget({
    Key? key,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Icon(
        iconData,
        color: Colors.grey,
      ),
    );
  }
}
