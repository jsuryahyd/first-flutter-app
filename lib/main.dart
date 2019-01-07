import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/authPage.dart';
import './pages/createProduct.dart';
import './pages/productsAdmin.dart';
import './pages/ProductPage.dart';
import './pages/ProductsListPage.dart';

import 'package:scoped_model/scoped_model.dart';
// import './scope_model/products.dart';
import './appScopedModel.dart';

void main() {
  runApp(MyApp());
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
}

class MyApp extends StatelessWidget {
  final appStateModel = new AppScopedModel();
  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return ScopedModel<AppScopedModel>(
      model: appStateModel,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.greenAccent,
        ),
        home: AuthPage(),
        routes: {
          'createProduct': (BuildContext context) => CreateProduct(),
          '/productsAdmin': (BuildContext context) => ProductsAdmin(appStateModel),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null; //path is not prefixed with '/'
          }
          switch (pathElements[1]) {
            case 'product':
              var index = (pathElements[2]);
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => ProductPage(index));
              break;
            case 'productsPage':
              return MaterialPageRoute(builder: (BuildContext context) {
                return ProductsListPage(appStateModel);
              });
              break;
            default:
              return null;
          }
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return ProductsListPage(appStateModel);
          });
        },
      ),
    );
  }
}
