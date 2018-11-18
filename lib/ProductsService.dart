import 'package:flutter/material.dart';

import './Products.dart';
import './ClearItemsButton.dart';

class ProductsService extends StatefulWidget {
  final Map defaultItem;
  ProductsService(this.defaultItem);
  @override
  State<StatefulWidget> createState() {
    return ProductsServiceState();
  }
}

class ProductsServiceState extends State<ProductsService> {
  List <Map>_items = [{'name':'sweet','img':'assets/images/sweet.jpg'}, {'name':'chutney','img':'assets/images/chutney.jpg'},{'name': 'pickle','img':'assets/images/pickle.jpg'}, {'name':'fry curry','img':'assets/images/fryCurry.jpg'}];

  void initState() {
    super.initState();
    Map defaultItem = widget.defaultItem;
    defaultItem != null ? _items.add(defaultItem) : () {}();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Products(_items,deleteProduct),
        )
      ],
    );
  }

  void addItems() {
    setState(() {
      {
        _items = [];
        print(_items);
      }
    });
  }

  @override
  void didUpdateWidget(ProductsService oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print(oldWidget);
  }

  void deleteProduct(index){
    setState(() {
          _items.removeAt(index);
          print(_items);
        });
  }
}
