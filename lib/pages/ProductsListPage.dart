import 'package:flutter/material.dart';

import '../childWidgets/ProductsListItem.dart';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';
import './partials/LogoutListTile.dart';
class ProductsListPage extends StatefulWidget {
  final AppScopedModel model;
  ProductsListPage(this.model);
  @override
  State<StatefulWidget> createState() => ProductsListPageState();
}

class ProductsListPageState extends State<ProductsListPage> {
  @override
// @mustCallSuper
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Column(children: <Widget>[
          AppBar(automaticallyImplyLeading: false, title: Text('choose')),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              // Navigator.pop(context);//close the drawer
              Navigator.popAndPushNamed(context, '/productsAdmin');
              // Navigator.pushReplacementNamed(context,'createProduct');
            },
          ),
          Divider(),
          LogoutListTile(),
        ])),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant(
              builder:
                  (BuildContext context, Widget child, AppScopedModel model) {
                return IconButton(
                  icon: Icon(model.showFavourites
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: model.toggleFavourites,
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<AppScopedModel>(
          builder: (BuildContext context, Widget child, AppScopedModel model) {
            return model.loadingProducts
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.products.isEmpty
                    ? Center(
                        child: Text('No Items Found'),
                      )
                    : Container(
                        margin: EdgeInsets.all(8.0),
                        child: RefreshIndicator(
                            child: ProductsListItem(model.showFavourites
                                ? model.products
                                    .where((p) => p.isFavourite)
                                    .toList()
                                : model.products),
                            onRefresh: ()=>model.fetchProducts(pullRefresh: true),),
                      );
          },
        ));
  }
}
