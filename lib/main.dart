import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './ProductsListPage.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
  debugPaintSizeEnabled = true;
  debugPaintPointersEnabled = true;
}

class MyApp extends StatelessWidget {
  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: ProductsListPage()
    );
  }
}
