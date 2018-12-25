import 'package:flutter/material.dart';

import './productInputPage.dart';
import '../models/Product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope_model/products.dart';
class MyProductsPage extends StatelessWidget {
  final List<Product> products;
  MyProductsPage(this.products);

  Widget build(context) {

    return Container(
      child: ScopedModelDescendant<ProductsScopedModel>(builder: (BuildContext context,Widget child,ProductsScopedModel model ){
        return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key:Key(products[index].id.toString()),
            background: Container(color: Colors.red,),
            onDismissed: (DismissDirection swipeDirection){
              if(swipeDirection == DismissDirection.endToStart){
                print('end to start');
                return model.deleteItem(products[index].id);
              }
            },
            child: Column(children: <Widget>[
            ListTile(
            leading: CircleAvatar(backgroundImage:AssetImage(this.products[index].imgUrl)),
            title: Text(
              this.products[index].title,
            ),
            subtitle: Text(products[index].description),
            trailing: IconButton(
              onPressed: (){
                ProductInputPage(product:this.products[index]);
                },
              icon: Icon(Icons.mode_edit),
            ),
          ),Divider()
          ],),);
        },
        itemCount: this.products.length,
      );
      },)
    );
  }
}
