import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/authPage.dart';
import './pages/createProduct.dart';
import './pages/productsAdmin.dart';
import './pages/ProductPage.dart';
import './pages/ProductsListPage.dart';

import  './models/Product.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  
  

  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.greenAccent,
      ),
      home: AuthPage(),
      routes: {
        'createProduct': (BuildContext context) => CreateProduct(),
        '/productsAdmin': (BuildContext context) => ProductsAdmin(addItem:this.addItem,deleteItem: this.deleteItem,
        items: this._items,editItem: this._editProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null; //path is not prefixed with '/'
        }
        switch (pathElements[1]) {
          case 'product':
            var index = int.parse(pathElements[2]);
            var item = _items[index];
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(item));
            break;
          case 'productsPage':
            return MaterialPageRoute(builder: (BuildContext context) {
              return ProductsListPage(this._items);
            });
            break;
          default:
            return null;
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return ProductsListPage(this._items);
        });
      },
    );
  }

  

  // @override
  // void didUpdateWidget(MyApp oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print(oldWidget);
  // }
}
