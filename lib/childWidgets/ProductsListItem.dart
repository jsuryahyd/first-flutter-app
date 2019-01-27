import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';
import '../models/Product.dart';

class ProductsListItem extends StatelessWidget {
  final List items;
  ProductsListItem(this.items);


Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _builderFunc,
      itemCount: items.length,
    ) ;
  }


  Widget _builderFunc(BuildContext context, int index) {
    Product item = items[index];
    return Card(
        child: new Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        FadeInImage(image: NetworkImage(item.imgUrl),placeholder: AssetImage('assets/images/sweet.jpg'),height:300,fit: BoxFit.cover,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              child: Text(
                "INR ${item.price.toString()}",
                style: TextStyle(fontSize: 12.0),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ],
        ),
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
          child: Padding(
            child: Text('Madhapur, Hyderabad'),
            padding: EdgeInsets.all(5.0),
          ),
        ),
        ButtonBar(
          // crossAxisAlignment: CrossAxisAlignment.center,
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.pushNamed(
                  context, '/product/' + item.id.toString()),
            ),
            ScopedModelDescendant<AppScopedModel>(
              builder: (BuildContext context, Widget child,
                  AppScopedModel model) {
                return IconButton(
                  icon: Icon(item.isFavourite ? Icons.favorite : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    item.isFavourite ? model.unFavouriteProduct(item.id) :  model.favouriteProduct(item.id);
                  },
                );
              },
            )
          ],
        ),
      ]),
    ));
  }

  
}
