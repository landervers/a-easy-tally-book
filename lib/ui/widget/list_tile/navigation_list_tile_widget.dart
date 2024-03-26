import 'package:flutter/material.dart';

import 'common_list_tile_widget.dart';

class NavigationListTileWidget extends StatelessWidget {

  final IconData iconData;

  final String title;

  final String answer;

  final Function()? onTap;

  const NavigationListTileWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.answer,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonListTileWidget(
      iconData: iconData,
      title: title,
      onTap: onTap,
      widgets: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text( answer,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
