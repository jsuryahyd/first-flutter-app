import 'package:flutter/material.dart';

import '../ProductsService.dart';

class ProductsListPage extends StatelessWidget {
  final Function addItem;
  final Function deleteItem;
  final List<Map<String,String>> items;



  ProductsListPage(this.items,this.deleteItem,this.addItem);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: <Widget>[
        AppBar(automaticallyImplyLeading: false, title: Text('choose')),
        ListTile(
          title: Text('Create Product'),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) {
            //     return CreateProduct();
            //   }),
            // );
            Navigator.pushReplacementNamed(context,'createProduct');
          },
        )
      ])),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Products(this.items,this.deleteItem,this.addItem),
      ),
    );
  }
}
