import 'package:flutter/material.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct();
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
            Navigator.pushNamed(
              context,
              '/productsAdmin'
              // '/productsAdmin'
            );
          },
        ),
      ),
    );
  }
}
