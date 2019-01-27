import 'package:scoped_model/scoped_model.dart';

import '../models/Product.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './connectedScopedModel.dart';
import '../models/userModel.dart';
mixin ProductsScopedModel on ConnectedScopedModel {
  bool _fetchingProducts = false;
  // User user = ConnectedScopedModel.user;
  get loadingProducts => _fetchingProducts;
bool _addProductProgress = false;
User user;
get addProductProgress => _addProductProgress;
  List<Product> _items = [
    // Product(
    //     id: "1",
    //     title: 'Sweet',
    //     imgUrl: 'assets/images/sweet.jpg',
    //     price: 200.0,
    //     description: 'Delicious. or is it?'),
    // Product(
    //     id: "2",
    //     title: 'Chutney',
    //     imgUrl: 'assets/images/chutney.jpg',
    //     price: 35.0,
    //     description: 'Tasty. isn\'t it?')
  ];

  String _selectedProductId;
  bool showFavourites = false;

  setSelectedProductId(id) {
    _selectedProductId = id;
    if(id != null ){
      notifyListeners();
    }
      }

  String get selectedProductId => _selectedProductId;

  List<Product> get products => _items;

  void clearItems() {
    {
      _items = [];
    }
  }

  Future<bool> deleteItem(String id) async {
http.Response deleted = await http.delete('https://flutter-udemy-course-practice.firebaseio.com/products/$id.json').catchError((err)=>print(err));
// if(!(deleted)){
//   // _deleteFail = true;
// }

if(deleted.statusCode != 200 || deleted.statusCode != 201){
  //_deleteFail = true | showDialog()
  return false;
}
    _items = _items.where((item) => item.id != id).toList();
    // _items.removeWhere((item)=>item['id'] == id)
    notifyListeners();
    return true;
  }

  Future<bool> addItem(Map item) async {
    _addProductProgress = true;
    notifyListeners();
    http.Response addItemResponse = await http
        .post(
            'https://flutter-udemy-course-practice.firebaseio.com/products.json',
            body: json.encode(item))
        .catchError((err) {
      print(err);
    });

    if (addItemResponse.statusCode != 200 && addItemResponse.statusCode != 201)
    {
print(addItemResponse);
_addProductProgress = false;
notifyListeners();
      return false;
    }
    Map<String, dynamic> addItemResponseMap = json.decode(addItemResponse.body);
    item["id"] = addItemResponseMap['name'];
Product product = Product(title: item['title'],price:item['price'],description: item['description'],imgUrl: '',id:addItemResponseMap['name']);
    _items.add(product);
    _addProductProgress = false;
    notifyListeners();
    return true;
  }

  Future<Null> editProduct(String id, Map<String, dynamic> changedValues) async {
var newValues = {
  "title": changedValues['title'],
        "price": changedValues['price'],
        "description": changedValues['description'],
        "imgUrl": changedValues['img'],
        "wishListedUsers": getProduct(id).wishListedUsers
};

http.Response updated = await http.put("https://flutter-udemy-course-practice.firebaseio.com/products/$id.json",body: json.encode(newValues)).catchError((err)=>print(err));

print(updated);


    int index = _items.indexWhere((item) => item.id == id);
    _items[index] = Product(
        id: id,
        title: changedValues['title'],
        price: changedValues['price'],
        description: changedValues['description'],
        imgUrl: changedValues['img'],
        wishListedUsers: getProduct(id).wishListedUsers);
    notifyListeners();
  }

  Product getProduct(id) {
    return _items.firstWhere((p) => p.id == id, orElse: () => null);
  }

  void favouriteProduct(id) {
    getProduct(id).favouriteProduct();
    notifyListeners();
  }

  void unFavouriteProduct(id) {
    getProduct(id).unFavouriteProduct();
    notifyListeners();
  }

  void toggleFavourites() {
    showFavourites = !showFavourites;
    notifyListeners();
  }

  Future<bool> fetchProducts({bool pullRefresh:false}) async {

if(!pullRefresh){
_fetchingProducts = true;
notifyListeners();
}
    http.Response fetchProductsResponse = await http
        .get(
            'https://flutter-udemy-course-practice.firebaseio.com/products.json?auth=$user.idToken')
        .catchError((err) => print(err));

    if (fetchProductsResponse.statusCode != 201 &&
        fetchProductsResponse.statusCode != 200) {
          _fetchingProducts = false;
          notifyListeners();
      return false;
    }
    Map<String, dynamic> fetchProductsResponseBody =
        json.decode(fetchProductsResponse.body);
    List<Product> fetchedProducts = [];
    (fetchProductsResponseBody??= {})
        .forEach((String productFirebaseId, dynamic item) {
      fetchedProducts.add(
        Product(
            id: productFirebaseId,
            price: item['price'],
            title: item['title'],
            wishListedUsers: item['wishListedUsers'],
            imgUrl: item['imgUrl'],
            description: item['description']),
      );
    });
    _items = fetchedProducts;
    _fetchingProducts = false;
    notifyListeners();
    return true;
  }
}
