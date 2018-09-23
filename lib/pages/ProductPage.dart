import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final Map item;
  ProductPage(this.item);

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
          ),
          body: Container(
            child: Column(children: <Widget>[
              Image.asset(item['img']),
              Text(item['name']),
              FlatButton(
                child: Text('Delete'),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ]),
          )),
    );
  }
}
