import 'package:flutter/material.dart';

class ProductsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      body: Container(
        child: RaisedButton(
            child: Text('Add a Product'),
            onPressed: () {
              print('hello...');
            }),
      ),
    );
  }
}
