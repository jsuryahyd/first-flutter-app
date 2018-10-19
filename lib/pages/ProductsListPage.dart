import 'package:flutter/material.dart';

import '../ProductsService.dart';
import './createProduct.dart';

class ProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: <Widget>[
        AppBar(automaticallyImplyLeading: false, title: Text('choose')),
        ListTile(
          title: Text('Create Product'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return CreateProduct();
              }),
            );
          },
        )
      ])),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: ProductsService(
            {'name': 'Sweet', 'img': 'assets/images/sweet.jpg'}),
      ),
    );
  }
}
