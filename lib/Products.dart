import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List items;
  Products(this.items);

  Widget build(BuildContext context) {
    return _buildProductsList(items);
  }

  _buildProductsList(items) {
    print(items);

    Widget productsWidget =
        Container(); //just so we dont return null if all cases fail.
    if (items.length == 0) {
      productsWidget = Center(child: Text('No items yet.'));
    } else if (items.length > 0 && items.length < 4) {
      productsWidget = Column(
        children: items
            .map((item) => Card(
                    child: new Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(children: <Widget>[
                    Image.asset('assets/traditional-lunch.jpg'),
                    Text(item)
                  ]),
                )))
            .toList(),
      );
    } else if (items.length >= 4) {
      productsWidget = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Column(children: [
            Image.asset('assets/traditional-lunch.jpg'),
            Text(items[index])
          ]));
        },
        itemCount: items.length,
      );
    }
    return productsWidget;
  }
}
