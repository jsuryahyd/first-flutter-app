import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List items;
  Products(this.items);

  Widget _builderFunc(BuildContext context, int index) {
    return Card(
        child: new Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        Image.asset('assets/traditional-lunch.jpg'),
        Text(items[index])
      ]),
    ));
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _builderFunc,
      itemCount: items.length,
    );
  }
}
