import 'package:flutter/material.dart';

import './Products.dart';
import './AddItemsButton.dart';

class ProductsService extends StatefulWidget {
  final String defaultItem;
  ProductsService(this.defaultItem);
  @override
  State<StatefulWidget> createState() {
    return ProductsServiceState();
  }
}

class ProductsServiceState extends State<ProductsService> {
  List _items = [];

  void initState() {
    super.initState();
    _items.add(widget.defaultItem);
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: RaisedButton(
                    child: Text('Add Item'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        {
                          _items.add('Afghan');
                          print(_items);
                        }
                      });
                    },
                  ),
                ),
                AddItemsButton(addItems),
              ],
            )),
      
        Expanded(child:Products(_items))
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
}
