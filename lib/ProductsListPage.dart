import 'package:flutter/material.dart';

import './ProductsService.dart';
class ProductsListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: Container(
            margin: EdgeInsets.all(8.0),
            child: ProductsService()),
      );
  }
  
}