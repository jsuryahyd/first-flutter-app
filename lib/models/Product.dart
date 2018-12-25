import 'package:meta/meta.dart';

class Product {
  // final
  String id;
  final String title;
  final double price;
  final String description;
  final String imgUrl;

  Product(
      {this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      this.imgUrl});
}
