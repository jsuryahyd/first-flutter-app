import 'package:meta/meta.dart';

class Product {
  // final
  String id;
  final String title;
  final double price;
  final String description;
  final String imgUrl;
  bool favourite;

  Product(
      {this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      this.imgUrl,
      this.favourite=false});


  favouriteProduct(){
this.favourite = true;
  }

  unFavouriteProduct(){
this.favourite = false;
  }

  dynamic serialize(){
    return {
      "title":this.title,
      "price":this.price,
      "description":this.description,
      "imgUrl":this.imgUrl,
      "favourite":this.favourite
    };
  }
}
