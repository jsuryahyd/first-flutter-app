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
          body: Column(children: <Widget>[
            Expanded(
            child: Column(children: <Widget>[
              Image.asset(item['img']),
              Text(item['name']),
              FlatButton(
                  child: Text('Delete'),
                  color: Theme.of(context).accentColor,
                  onPressed: ()=>showWarningDialog(context),),
            ])),
          ])
    ));
  }

  showWarningDialog(context) {
     showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('You cannot Undo this.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel',style: TextStyle(color: Theme.of(context).primaryColor),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Delete',style: TextStyle(color: Theme.of(context).primaryColor),),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}
