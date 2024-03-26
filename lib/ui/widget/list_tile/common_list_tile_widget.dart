import 'package:account_book/ui/widget/my_divider_widget.dart';
import 'package:flutter/material.dart';

class CommonListTileWidget extends StatelessWidget {

  final IconData iconData;

  final String title;

  final List<Widget> widgets;

  final Function()? onTap;

  CommonListTileWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.widgets,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: ListTile(
            title:Row(
              children: [
                Icon(
                  iconData,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(title, style: Theme.of(context).textTheme.bodyText2),
              ] + widgets
            ),
            trailing: onTap == null ? null : Icon(Icons.arrow_forward_ios, size: 15,color: Colors.grey,),
            onTap: onTap,
          ),
        ),
        MyDividerWidget(),
      ],
    );
  }
}
