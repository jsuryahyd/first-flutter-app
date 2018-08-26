import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body:Container(
      child: Column(children: <Widget>[
        Image.asset('assets/traditional-lunch.jpg'),
        Text('Sweet'),
        FlatButton(child: Text('Back'), color: Theme.of(context).accentColor, onPressed: () {Navigator.pop(context)},),
      ]),
    )
    );
  }
}
