import 'package:flutter/material.dart';

import './Products.dart';

class Products extends StatelessWidget {
  final items;
 Products(this.items);
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ProductsList(this.items),
        )
      ],
    );
  }  
}
