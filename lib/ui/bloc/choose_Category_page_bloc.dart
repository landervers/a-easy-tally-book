import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/route/page_bloc.dart';
import 'package:account_book/route/page_name.dart';
import 'package:account_book/ui/bloc/core/store_page_bloc.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:rxdart/rxdart.dart';

import '../model/amount_data.dart';

class ChooseCategoryPageBloc extends PageBloc {
  ChooseCategoryPageBloc(BlocOption blocOption) : super(blocOption);

  List<DraggableGridItem> listOfDraggableGridItem = [];

  int get currentCategoryIndex =>
      option.query[BlocOptionKey.CurrentCategoryKey];

  StorePageBloc get storePageBloc => option.query[BlocOptionKey.StorePageBlocKey];

  BehaviorSubject<int> get categoryIndexSubject => option.query[BlocOptionKey.CategoryIndexSubject];

  int chooseCategoryIndex = 0;

  List<AmountCategory> get xx =>
  option.query[BlocOptionKey.AmountCategoryKey];

  /// 记录当前选择
  BehaviorSubject<int> _chooseCategorySubject = BehaviorSubject.seeded(0);

  Stream<int> get chooseCategoryStream => _chooseCategorySubject.stream;

  void changeCategory(int index) {
    chooseCategoryIndex = index;
    _chooseCategorySubject.add(chooseCategoryIndex);
    storePageBloc.currentAmountData.categoryIndex = chooseCategoryIndex;
    categoryIndexSubject.add(index);
  }
}