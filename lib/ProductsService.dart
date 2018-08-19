import 'package:flutter/material.dart';

import './Products.dart';

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
                RaisedButton(
                  child: Text('Add Item'),
                  onPressed: () {
                    setState(() {
                      {
                        _items.add('Afghan');
                        print(_items);
                      }
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Clear Items'),
                  onPressed: () {
                    setState(() {
                      {
                        _items = [];
                        print(_items);
                      }
                    });
                  },
                ),
              ],
            )),
        Products(_items)
      ],
    );
  }
}
