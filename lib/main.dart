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
import 'package:map_view/map_view.dart';
import './keys.dart';
void main() {
  MapView.setApiKey(mapsApiKey);
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

class MyAppState extends State<MyApp>{
  final appStateModel = new AppScopedModel();
bool isLoggedIn = false;
void initState(){
  appStateModel.autoLogin();
  appStateModel.authSubject.listen((bool isAuthorized) => setState((){
    isLoggedIn = isAuthorized;
    }));
  super.initState();
}

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
        // home: AuthPage(),
        routes: {
          // '/':(BuildContext context) => ScopedModelDescendant(builder: (BuildContext context,Widget child,AppScopedModel model ){
          //   return model.user == null ? AuthPage(): ProductsListPage(appStateModel) ;
          // },),
          '/':(BuildContext context) =>isLoggedIn ?  ProductsListPage(appStateModel) : AuthPage(),
          'createProduct': (BuildContext context) => isLoggedIn ? CreateProduct() : AuthPage(),
          '/productsAdmin': (BuildContext context) => isLoggedIn ?  ProductsAdmin(appStateModel): AuthPage(),
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
