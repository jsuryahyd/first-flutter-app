import 'package:flutter/material.dart';

import './pages/ProductPage.dart';

class Products extends StatelessWidget {
  final List items;
  final Function deleteProduct;
  Products(this.items, this.deleteProduct);


  Widget _builderFunc(BuildContext context, int index) {
    Map item = items[index];
    return Card(
        child: new Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        Image.asset(item['img']),
        Text(item['name']),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Details'),
              onPressed: () => Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductPage(item))).then((bool back){
                        if(back == true){
                          deleteProduct(index);
                        }
                      }),
            ),
          ],
        )
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
