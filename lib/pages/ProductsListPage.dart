import 'package:flutter/material.dart';

import '../childWidgets/ProductsListItem.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope_model/products.dart';

class ProductsListPage extends StatelessWidget {
  ProductsListPage();
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
              Navigator.popAndPushNamed(context, '/productsAdmin');
              // Navigator.pushReplacementNamed(context,'createProduct');
            },
          )
        ])),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.favorite), onPressed: () {})
          ],
        ),
        body: ScopedModelDescendant(
          builder:
              (BuildContext context, Widget child, ProductsScopedModel model) {
            return Container(
                margin: EdgeInsets.all(8.0),
                child: ProductsListItem(model.products));
          },
        ));
  }
}
