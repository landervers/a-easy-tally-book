import 'package:account_book/extension/datetime_extension.dart';
import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/route/transition_enum.dart';
import 'package:account_book/ui/bloc/core/store_page_bloc.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/widget/appbars/store_page_appbar.dart';
import 'package:account_book/ui/widget/list_tile/navigation_list_tile_widget.dart';
import 'package:account_book/ui/widget/list_tile/text_edit_tile_widget.dart';
import 'package:account_book/ui/widget/my_divider_widget.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late StorePageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<StorePageBloc>(context);
    bloc.initCurrentData();
    bloc.setView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
               children: [
               StorePageAppBar(bloc: bloc),
                Expanded(
      child: ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics()),
        children: [
               _buildDateTileWidget(),
                TextEditTileWidget(controller: bloc.textEditingController),
                _buildCategoryTile(),
                _buildAccountTypeTileWidget(),
                _buildMemberTileWidget(),
                _buildMoodTileWidget(),
                _buildMemoTextEditWidget(),
                _buildBottomButton(),
              ],
            ),
   )
        ],
      )),
    );
  }

  Widget _buildDateTileWidget() {
    return Column(
      children: [
        ListTile(
          tileColor: Theme.of(context).colorScheme.tertiary,
          title: InkWell(
            onTap: () {},
            child: Center(
                child: Text(
              bloc.currentAmountData.date.formatToTW(),
              style: Theme.of(context).textTheme.bodyLarge,
            )),
          ),
        ),
        MyDividerWidget(),
      ],
    );
  }

  Widget _buildCategoryTile() {
    return StreamBuilder<int>(
      initialData: 0,
      stream: bloc.categoryIndexStream,
      builder: (context, snapshot) {
        var index = snapshot.requireData;
        // 确保索引在有效范围内
        if (index >= 0 && index < ApplicationBloc.getInstance().amountCategoryList.length) {
          return NavigationListTileWidget(
            title: '消费类型',
            iconData: ApplicationBloc.getInstance().amountCategoryList[index].iconData,
            answer: ApplicationBloc.getInstance().amountCategoryList[index].categoryName,
            onTap: () {
              bloc.pushPage(
                PageName.ChooseCategoryPage,
                context,
                transitionEnum: TransitionEnum.RightLeft,
                blocQuery: {
                  BlocOptionKey.CurrentCategoryKey: bloc.currentAmountData.categoryIndex,
                  BlocOptionKey.StorePageBlocKey: bloc,
                  BlocOptionKey.CategoryIndexSubject:bloc.categoryIndexSubject,
                  BlocOptionKey.AmountCategoryKey: ApplicationBloc.getInstance().amountCategoryList
                },
              );
            },
          );
        } else {
          // 处理索引超出范围的情况
          print('Index out of range: $index');
          return SizedBox(); // 返回一个空的Widget，或者根据需要返回适当的提示信息
        }
      },
    );
  }



  Widget _buildAccountTypeTileWidget() {
    return StreamBuilder<int>(
        initialData: 0,
        stream: bloc.methodCategoryIndexStream,
        builder: (context, snapshot) {
          var index = snapshot.requireData;
          return NavigationListTileWidget(
            title: '支付方式',
            iconData: ApplicationBloc.getInstance()
                .PaidMethod [index]
                .iconData,
            answer: ApplicationBloc.getInstance()
                .PaidMethod [index]
                .categoryName,
            onTap: () {
              bloc.pushPage(PageName.ChooseCategoryPage, context,
                  transitionEnum: TransitionEnum.RightLeft,
                  blocQuery: {
                    BlocOptionKey.CurrentCategoryKey:
                    bloc.currentAmountData.categoryIndex,
                    BlocOptionKey.StorePageBlocKey: bloc,
                    BlocOptionKey.CategoryIndexSubject:bloc.methodCategoryIndexSubject,
                    BlocOptionKey.AmountCategoryKey:ApplicationBloc.getInstance().PaidMethod
                  });
            },
          );
        });
  }

  Widget _buildMemberTileWidget() {
    return StreamBuilder<int>(
        initialData: 0,
        stream: bloc.consumerCategoryIndexStream,
        builder: (context, snapshot) {
          var index = snapshot.requireData;
          return NavigationListTileWidget(
            title: '消费人',
            iconData: ApplicationBloc.getInstance()
                .consumer [index]
                .iconData,
            answer: ApplicationBloc.getInstance()
                .consumer [index]
                .categoryName,
            onTap: () {
              bloc.pushPage(PageName.ChooseCategoryPage, context,
                  transitionEnum: TransitionEnum.RightLeft,
                  blocQuery: {
                    BlocOptionKey.CurrentCategoryKey:
                    bloc.currentAmountData.categoryIndex,
                    BlocOptionKey.StorePageBlocKey: bloc,
                    BlocOptionKey.CategoryIndexSubject:bloc.consumerCategoryIndexSubject,
                    BlocOptionKey.AmountCategoryKey:ApplicationBloc.getInstance().consumer
                  });
            },
          );
        });
  }
  Widget _buildMoodTileWidget() {
    return StreamBuilder<int>(
        initialData: 0,
        stream: bloc.moodCategoryIndexStream,
        builder: (context, snapshot) {
          var index = snapshot.requireData;
          return NavigationListTileWidget(
            title: '消费体验',
            iconData: ApplicationBloc.getInstance()
                .PaidMood [index]
                .iconData,
            answer: ApplicationBloc.getInstance()
                .PaidMood [index]
                .categoryName,
            onTap: () {
              bloc.pushPage(PageName.ChooseCategoryPage, context,
                  transitionEnum: TransitionEnum.RightLeft,
                  blocQuery: {
                    BlocOptionKey.CurrentCategoryKey:
                    bloc.currentAmountData.categoryIndex,
                    BlocOptionKey.StorePageBlocKey: bloc,
                    BlocOptionKey.CategoryIndexSubject:bloc.moodCategoryIndexSubject,
                    BlocOptionKey.AmountCategoryKey:ApplicationBloc.getInstance().PaidMood
                  });
            },
          );
        });
  }


  Widget _buildMemoTextEditWidget() {
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom == 0
          ? MediaQuery.of(context).size.height * 0.38
          : MediaQuery.of(context).size.height * 0.30,
      color: Theme.of(context).colorScheme.tertiary,
      margin: EdgeInsets.only(top: 35, bottom: 5),
      padding: EdgeInsets.all(10),
      child: TextField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '备注...',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Row(
      children: [
        Expanded(flex: 1, child: SizedBox.shrink()),
        Expanded(
          flex: 8,
          child: ElevatedButton(
            onPressed: () {
              bloc.save();
              Navigator.of(context).pop();
            },
            child: Text(
              "确定",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).secondaryHeaderColor,
                ), backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                visualDensity: VisualDensity(vertical: 1)),
          ),
        ),
        Expanded(flex: 1, child: SizedBox.shrink()),
        // Expanded(
        //   flex: 8,
        //   child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //           backgroundColor: Theme.of(context).secondaryHeaderColor,
        //           visualDensity: VisualDensity(vertical: 1)),
        //       onPressed: () {},
        //       child: Text("记新账",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ))),
        // ),
        // Expanded(flex: 1, child: SizedBox.shrink()),
      ],
    );
  }
}
