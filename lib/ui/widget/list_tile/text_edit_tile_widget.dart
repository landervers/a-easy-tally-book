import 'package:flutter/material.dart';

import 'common_list_tile_widget.dart';

class TextEditTileWidget extends StatefulWidget {
  final TextEditingController controller;

  const TextEditTileWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<TextEditTileWidget> createState() => _TextEditTileWidgetState();
}

class _TextEditTileWidgetState extends State<TextEditTileWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonListTileWidget(
      iconData: Icons.attach_money,
      title: "金额",
      widgets: [
        Expanded(
          child: TextField(
            style: Theme.of(context).textTheme.bodyText2,
            autofocus: true,
            textAlign: TextAlign.right,
            controller: widget.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hoverColor: Colors.white,
              focusColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              hintText: "请输入金额",
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey)
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        if(widget.controller.text.isNotEmpty)
          InkWell(
            onTap: () {
              setState(() {
                widget.controller.clear();
              });
            },
            child: Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Icon(
                Icons.clear,
                color: Colors.black,
                size: 20,
              ),
            ),
          )
      ],

    );
  }
}
