import 'package:flutter/material.dart';

// import './pages/ProductPage.dart';

class ProductsList extends StatelessWidget {
  final List items;
  ProductsList(this.items);

  Widget _builderFunc(BuildContext context, int index) {
    Map item = items[index];
    return Card(
        child: new Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        Image.asset(item['img']),
        Padding(
          child: Text(item['name']),
          padding: EdgeInsets.symmetric(vertical:10.0),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Details'),
              onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      // MaterialPageRoute(
                      //     builder: (BuildContext context) => ProductPage(item))).then((bool back){
                      //       if(back == true){
                      //         deleteProduct(index);
                      //       }
                      //     }),

                      '/product/' + index.toString())
                  .then((bool back) {}),
            )
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
