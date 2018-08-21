import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List items;
  Products(this.items);

  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Card(
                child: Column(children: <Widget>[
                  //Image.asset('assets/traditional-lunch.jpg'),
                  Text(item)
                ]),
              ))
          .toList(),
    );
  }
}
