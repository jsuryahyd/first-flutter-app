import 'package:flutter/material.dart';

import './ProductsService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: Container(margin: EdgeInsets.all(8.0), child: ProductsService('South Indian')),
      ),
    );
  }
}
