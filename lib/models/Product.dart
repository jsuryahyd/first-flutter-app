import 'package:meta/meta.dart';

class Product {
  // final
  String id;
  final String title;
  final double price;
  final String description;
  final String imgUrl;
  var wishListedUsers;
  bool isFavourite;
  final String createdBy;

  Product(
      {this.id,
      this.createdBy,
      @required this.title,
      @required this.price,
      @required this.description,
      this.imgUrl,
      this.isFavourite,
      this.wishListedUsers});

  favouriteProduct() {
    isFavourite = true;
  }

  unFavouriteProduct() {
    isFavourite = false;
  }

  dynamic serialize() {
    return {
      "title": this.title,
      "price": this.price,
      "description": this.description,
      "imgUrl": this.imgUrl,
      "favourite": this.isFavourite
    };
  }
}
