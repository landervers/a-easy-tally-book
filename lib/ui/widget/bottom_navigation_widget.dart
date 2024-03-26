import 'package:account_book/route/page_name.dart';
import 'package:account_book/ui/model/bottom_navigation_model.dart';
import 'package:account_book/ui/widget/material_ink_widget.dart';
import 'package:account_book/ui/widget/my_divider_widget.dart';
import 'package:flutter/material.dart';

typedef BottomTapCallback = void Function(BottomNavigationData data);

class BottomNavigationWidget extends StatelessWidget {
  final List<BottomNavigationData> bottomNavigationList;

  final String currentRouteName;

  final BottomTapCallback onTap;

  const BottomNavigationWidget(
      {Key? key,
      required this.bottomNavigationList,
      required this.currentRouteName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Column(
            children: [
              MyDividerWidget(height: 0.1),
              Expanded(
                child: Row(
                  children:
                      bottomNavigationList.map((e) => _buildItemWidget(context, e)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget(BuildContext context, BottomNavigationData data) {
    /// 是否要高亮
    bool isSelect =
        currentRouteName.isNotEmpty && data.url.contains(currentRouteName);
    bool isStorePage =
        currentRouteName.isNotEmpty && data.url.contains(PageName.StorePage);

    Color textColor = isSelect ? Theme.of(context).secondaryHeaderColor : Colors.grey;
    Color iconColor = isStorePage
        ? Theme.of(context).secondaryHeaderColor
        : isSelect
            ? Theme.of(context).secondaryHeaderColor
            : Colors.grey;
    IconData iconData = data.icon;

    Widget commonWidget = Container(
      color: Theme.of(context).colorScheme.tertiary,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 4,
        left: 4,
        right: 4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Icon(
              iconData,
              size: iconData == Icons.add? 30: 24,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 3),
          Expanded(
            child: FittedBox(
              child: Text(
                data.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: textColor,
                    ),
                  ],
                ),
              ),
              fit: BoxFit.scaleDown,
            ),
          )
        ],
      ),
    );

    return Expanded(
        child: MaterialInkWidget(
      child: commonWidget,
      onTap: () => onTap(data),
    ));
  }
}
