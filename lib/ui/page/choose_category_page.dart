import 'package:account_book/route/base_bloc.dart';
import 'package:account_book/ui/bloc/choose_Category_page_bloc.dart';
import 'package:account_book/ui/bloc/system/application_bloc.dart';
import 'package:account_book/ui/widget/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

class ChooseCategoryPage extends StatefulWidget {
  const ChooseCategoryPage({Key? key}) : super(key: key);

  @override
  ChooseCategoryPageState createState() => ChooseCategoryPageState();
}

class ChooseCategoryPageState extends State<ChooseCategoryPage> {
  late ChooseCategoryPageBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChooseCategoryPageBloc>(context);
    _generateImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonAppBarWidget(
              title: Text("请选择"),
          ),
          Expanded(
            child: DraggableGridViewBuilder(
              padding: EdgeInsets.symmetric(vertical: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.8),
              ),
              children: bloc.listOfDraggableGridItem,
              dragCompletion: onDragAccept,
              dragFeedback: feedback,
              dragPlaceHolder: placeHolder,
            ),
          ),
        ],
      ),
    );
  }

  void onDragAccept(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    print('onDragAccept: $beforeIndex -> $afterIndex');
  }

  Widget feedback(List<DraggableGridItem> list, int index) {
    return SizedBox(
      child: list[index].child,
      width: 110,
      height: 80,
    );
  }

  PlaceHolderWidget placeHolder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  void _generateImageData() {
    bloc.xx
        .asMap()
        .forEach((index, amountCategory) {
      bloc.listOfDraggableGridItem.add(DraggableGridItem(
        child: StreamBuilder<int>(
          stream: bloc.chooseCategoryStream,
          initialData: 0,
          builder: (context, snapshot) {
            return Card(
                color: Theme.of(context).primaryColor,
                shape: index == snapshot.requireData
                    ? RoundedRectangleBorder(
                        side: BorderSide(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(8))
                    : null,
                child: InkWell(
                  onTap: (){
                    bloc.changeCategory(index);
                    Navigator.of(context).pop();
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child:
                                Icon(amountCategory.iconData, color: Colors.orange)),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              amountCategory.categoryName,
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ))
                    ],
                  ),
                ));
          }
        ),
        isDraggable: true,
        dragCallback: (context, isDragging) {
          print('isDragging: $isDragging');
        },
      ));
    });
  }
}
