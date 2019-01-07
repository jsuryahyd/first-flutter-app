import 'package:flutter/material.dart';
import './productInputPage.dart';
import './MyProductsPage.dart';
import '../appScopedModel.dart';
class ProductsAdmin extends StatelessWidget {
 final AppScopedModel model;
  ProductsAdmin(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Manage Products'),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Add a Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ])),
        body: TabBarView(children:<Widget>[
          ProductInputPage(),
          MyProductsPage(model)
        ])
      ),
    );
  }
}
