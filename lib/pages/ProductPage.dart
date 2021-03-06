import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';

class ProductPage extends StatelessWidget {
  final String itemId;
  ProductPage(this.itemId);

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
          child: ScopedModelDescendant<AppScopedModel>(
            builder: (BuildContext context, Widget child,
                AppScopedModel model) {
              final item = model.getProduct(itemId);
              if(item == null){
                return Container(child: Text('No Data Available'),);
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network(item.imgUrl),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0),
                          ),
                          Text(
                            'INR ' + item.price.toString(),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
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
