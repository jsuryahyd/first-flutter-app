import 'package:flutter/material.dart';

import './Products.dart';
import './ClearItemsButton.dart';

class Products extends StatelessWidget {
  final Function deleteItem;
  final Function addItem;
  final items;
 Products(this.items,this.deleteItem,this.addItem);
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
                    onPressed: this.addItem,
                  ),
                ),
                // ClearItemsButton(this.clearItems),
              ],
            )),
        Expanded(
          child: ProductsList(this.items,this.deleteItem),
        )
      ],
    );
  }  
}
