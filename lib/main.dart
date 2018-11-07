import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/authPage.dart';
import './pages/createProduct.dart';
import './pages/productsAdmin.dart';
import './pages/ProductPage.dart';
import './pages/ProductsListPage.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<Map<String,String>> _items = [
    {'name': 'sweet', 'img': 'assets/images/sweet.jpg'},
    {'name': 'chutney', 'img': 'assets/images/chutney.jpg'},
    {'name': 'pickle', 'img': 'assets/images/pickle.jpg'},
    {'name': 'fry curry', 'img': 'assets/images/fryCurry.jpg'}
  ];

  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.yellowAccent,
      ),
      home: AuthPage(),
      routes: {
        'createProduct': (BuildContext context) => CreateProduct(),
        '/productsAdmin': (BuildContext context) => ProductsAdmin(),
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
              return ProductsListPage(
                  this._items, this.deleteItem, this.addItem,);
            });
            break;
          default:
            return null;
        }
      },
      onUnknownRoute: (RouteSettings settings){
        return MaterialPageRoute(builder: (BuildContext context) {
              return ProductsListPage(
                  this._items, this.deleteItem, this.addItem,);
            });
      },
    );
  }

  void clearItems() {
    setState(() {
      {
        _items = [];
        print(_items);
      }
    });
  }

  void deleteItem(index) {
    setState(() {
      _items.removeAt(index);
      print(_items);
    });
  }

  void addItem() {
    setState(() {
      {
        _items.add({'name': 'Naan', 'img': 'assets/images/naan.jpg'});
        print(_items);
      }
    });
  }

  // @override
  // void didUpdateWidget(MyApp oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print(oldWidget);
  // }
}
