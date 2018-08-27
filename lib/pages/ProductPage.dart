import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
final Map item;
ProductPage(this.item);


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body:Expanded(
      child: Column(children: <Widget>[
        Image.asset(item['img']),
        Text(item['name']),
        FlatButton(child: Text('Back'), color: Theme.of(context).accentColor, onPressed: () {Navigator.pop(context);},),
      ]),
    )
    );
  }
}
