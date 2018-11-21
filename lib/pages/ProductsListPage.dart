import 'package:flutter/material.dart';

import '../ProductsService.dart';


class ProductsListPage extends StatelessWidget {
  final List<Map<String,dynamic>> items;



  ProductsListPage(this.items);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: <Widget>[
        AppBar(automaticallyImplyLeading: false, title: Text('choose')),
        ListTile(
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
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Products(this.items),
      ),
    );
  }
}
