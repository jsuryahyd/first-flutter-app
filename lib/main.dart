import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/authPage.dart';
import './pages/createProduct.dart';
import './pages/productsAdmin.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
}

class MyApp extends StatelessWidget {
  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.yellowAccent,
      ),
      home: AuthPage(),
      routes:{
        'createProduct':(BuildContext context)=>CreateProduct(),
        '/productsAdmin':(BuildContext context)=>ProductsAdmin(),
       },
      // onGenerateRoute: (RouteSettings settings){
      //   final List<String> pathElements = settings.name.split('/');

      // },
    );
  }
}
