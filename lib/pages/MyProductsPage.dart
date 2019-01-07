import 'package:flutter/material.dart';

import './productInputPage.dart';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';

class MyProductsPage extends StatefulWidget {
final AppScopedModel model;
  MyProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
      return MyProductsPageState();
    }
}

class MyProductsPageState extends State<MyProductsPage>{
@override
initState(){
widget.model.fetchProducts();
super.initState();
}

  Widget build(context) {
    return Container(child: ScopedModelDescendant<AppScopedModel>(
      builder: (BuildContext context, Widget child, AppScopedModel model) {
        final products = model.products;
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(products[index].id.toString()),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection swipeDirection) {
                if (swipeDirection == DismissDirection.endToStart) {
                  print('end to start');
                  return model.deleteItem(products[index].id);
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(products[index].imgUrl)),
                    title: Text(
                      products[index].title,
                    ),
                    subtitle: Text(products[index].description),
                    trailing: IconButton(
                      onPressed: () {
                        model.setSelectedProductId(products[index].id);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ProductInputPage();
                          }),
                        ).then((_){model.setSelectedProductId(null);});
                      },
                      icon: Icon(Icons.mode_edit),
                    ),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: products.length,
        );
      },
    ));
  }
}
