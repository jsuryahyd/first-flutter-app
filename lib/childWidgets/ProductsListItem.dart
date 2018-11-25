import 'package:flutter/material.dart';

// import './pages/ProductPage.dart';

class ProductsListItem extends StatelessWidget {
  final List items;
  ProductsListItem(this.items);

  Widget _builderFunc(BuildContext context, int index) {
    Map item = items[index];
    return Card(
        child: new Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        Image.asset(item['img']),
        Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                            fontSize: 26.0,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:6.0,vertical: 3.0),
                      child: Text("INR ${item['price'].toString()}",style: TextStyle(fontSize: 12.0),),
                      decoration:
                          BoxDecoration(color: Theme.of(context).accentColor,borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ],
                ),
                    DecoratedBox(decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1.0),
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                    child: Padding(child: Text('Madhapur, Hyderabad'),padding:EdgeInsets.all(5.0),),),
                ButtonBar(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                  IconButton(
                  icon: Icon(Icons.info),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pushNamed(context, '/product/'+index.toString()),
                ),IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                  onPressed: () {print(this);},
                ),
                ],),
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
