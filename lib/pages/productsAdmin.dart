import 'package:flutter/material.dart';
import './productCreatePage.dart';
import './productListPage.dart';


class ProductsAdmin extends StatelessWidget {
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
          ProductCreatePage(),
          ProductListPage()
        ])
      ),
    );
  }
}
