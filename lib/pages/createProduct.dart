import 'package:flutter/material.dart';
import './productsAdmin.dart';

class CreateProduct extends StatelessWidget {
  // CreateProduct()
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Create New'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductsAdmin(),
              ),
              // '/productsAdmin'
            );
          },
        ),
      ),
    );
  }
}
