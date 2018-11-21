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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                            fontSize: 26.0,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:6.0,vertical: 3.0),
                      child: Text("INR ${item['price'].toString()}",style: TextStyle(fontSize: 12.0),),
                      decoration:
                          BoxDecoration(color: Theme.of(context).accentColor,borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ],
                ),
                    DecoratedBox(decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1.0),
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                    child: Padding(child: Text('Madhapur, Hyderabad'),padding:EdgeInsets.all(5.0),),),
                FlatButton(
                  child: Text('Delete'),
                  color: Theme.of(context).accentColor,
                  onPressed: () => showWarningDialog(context),
                ),
              ])),
            ])));
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
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
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
