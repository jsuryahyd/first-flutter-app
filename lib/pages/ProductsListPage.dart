import 'package:flutter/material.dart';

import '../childWidgets/ProductsListItem.dart';

import '../models/Product.dart';

class ProductsListPage extends StatelessWidget {
  final List<Product> items;



  ProductsListPage(this.items);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: <Widget>[
        AppBar(automaticallyImplyLeading: false, title: Text('choose')),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            // Navigator.pop(context);//close the drawer
            Navigator.popAndPushNamed(
              context,
              '/productsAdmin'
            );
            // Navigator.pushReplacementNamed(context,'createProduct');
          },
        )
      ])),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
          icon:Icon(Icons.favorite),
          onPressed:(){})
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: ProductsListItem(this.items),
      ),
    );
  }
}
