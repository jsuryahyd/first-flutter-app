import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List items;
  Products(this.items);

  Widget build(BuildContext context) {
    Widget productsWidget =  Center(child:Text('No items yet.'));
    if(items.length > 0){
      productsWidget = Column(
      children: items
          .map((item) => Card(child:new Padding( padding:EdgeInsets.all(5.0),
                child: Column(children: <Widget>[
                  Image.asset('assets/traditional-lunch.jpg'),
                  Text(item)
                ]),)
              ))
          .toList(),
    );
    }
    return productsWidget;
  }
}
