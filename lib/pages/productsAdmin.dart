import 'package:flutter/material.dart';
import './productInputPage.dart';
import './MyProductsPage.dart';
import '../models/Product.dart';

class ProductsAdmin extends StatelessWidget {
 final Function addItem;
 final Function deleteItem;
 final List<Product> items;
 final Function editItem;
  ProductsAdmin({this.addItem,this.deleteItem,this.items,this.editItem});
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
          ProductInputPage(addProduct:this.addItem),
          MyProductsPage(this.items,this.editItem,this.deleteItem)
        ])
      ),
    );
  }
}
