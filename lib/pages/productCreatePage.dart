import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductCreatePageState();
  }
}

class ProductCreatePageState extends State<ProductCreatePage> {
  String _titleInput = '';
  String _description ='';
  double _price;

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(15.0),
        child: ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Product Title'),
          autocorrect: true,
          onChanged: (String inputValue) {
            setState(() {
              _titleInput = inputValue;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Product Description'),
          maxLines: 4,
          onChanged: (String inputValue) {
            setState(() {
              _description = inputValue;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
          onChanged: (String inputValue) {
            setState(() {
              _price = double.parse(inputValue);
            });
          },
        ),
        RaisedButton(onPressed: (){},child: Text('Add Product'),)
      ],
    ));
  }
}
