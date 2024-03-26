import 'package:account_book/ui/bloc/core/store_page_bloc.dart';
import 'package:account_book/ui/widget/common_app_bar_widget.dart';
import 'package:flutter/material.dart';

class StorePageAppBar extends StatelessWidget {
  final StorePageBloc bloc;
  const StorePageAppBar({
    Key? key,
    required this.bloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonAppBarWidget(
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (bloc.textEditingController.text.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("请输入金额"),
                        actions: [
                          ElevatedButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    });
              } else {
                bloc.save();
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "保存",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))
      ],
      title: Text("记一笔"),
    );
  }
}
