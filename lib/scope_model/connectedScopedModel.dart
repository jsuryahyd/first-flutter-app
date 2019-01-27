import 'package:scoped_model/scoped_model.dart';
import '../models/userModel.dart';
import '../models/authModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Product.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

mixin ConnectedScopedModel on Model {
  User _loggedInUser;
}

mixin UserScopedModel on ConnectedScopedModel {
  bool _authProgess = false;
  get authProgress => _authProgess;
  get user => _loggedInUser;
  PublishSubject<bool> _authSubject = PublishSubject();
  PublishSubject<bool> get authSubject {
    return _authSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String pwd,
      [authMode = AuthMode.login]) async {
    this._authProgess = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': pwd,
      'returnSecureToken': true
    };

    final http.Response authResponse = authMode == AuthMode.login
        ? await http.post(
            'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
            body: json.encode(authData),
            headers: {
                'Content-type': 'application/json'
              })
        : await http.post(
            'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
            body: json.encode(authData),
            headers: {'Content-type': 'application/json'});
    ;
    if (authResponse == null) {
      return {
        "success": false,
        "msg": 'An Error Occured while Authentication.'
      };
    }
    var authResponseBody = json.decode(authResponse.body);
    _authProgess = false;
    print('response -- ' + jsonEncode(authResponseBody));
    notifyListeners();
    if (authResponse.statusCode != 200) {
      var msg = 'An Error Occured while Authentication.';
      switch (authResponseBody['error']['message']) {
        case 'EMAIL_NOT_FOUND':
          msg = 'Given email doesnot exist.';
          break;
        case 'INVALID_PASSWORD':
          msg = 'Authentication Failed.';
          break;
        case 'USER_DISABLED':
          msg = 'Access Denied.';
          break;
        case 'EMAIL_EXISTS':
          msg = 'Given email already exists.';
          break;
        case 'OPERATION_NOT_ALLOWED':
          msg =
              'We cannot process your request. Please try again another Authentication method.';
          break;
        case 'TOO_MANY_ATTEMPTS_TRY_LATER':
          msg = 'Max attempts reached. Please try again after some time.';
          break;
      }
      return {"success": false, "msg": msg};
    }
    _loggedInUser = User(
        email: authResponseBody["email"],
        id: authResponseBody["localId"],
        idToken: authResponseBody["idToken"]);
    if (authResponseBody["idToken"] == null) {
      return {"success": false};
    }
_authSubject.add(true);
    final storage = await SharedPreferences.getInstance();
    storage.setString('idToken', authResponseBody['idToken']);
    storage.setString('email', authResponseBody['email']);
    storage.setString('firebaseId', authResponseBody['localId']);
    return {"success": true};
    
  }

  autoLogin() async {
    final storage = await SharedPreferences.getInstance();
    final idToken = storage.getString('idToken');
    if (idToken == null) {
      return false;
    }
    _loggedInUser = User(
      email: storage.getString('email'),
      id: storage.getString("firebaseId"),
      idToken: storage.getString("idToken"),
    );
    // notifyListeners();
    _authSubject.add(true);
  }

  logout() async {
    _loggedInUser = null;
    final storage = await SharedPreferences.getInstance();
    storage.remove('idToken');
    storage.remove('email');
    storage.remove('firebaseId');
    _authSubject.add(false);
  }

  // Future<Map<String, dynamic>> signup(String email, String pwd) async {
  //   _authProgess = true;
  //   notifyListeners();
  //   final Map<String, dynamic> authData = {
  //     'email': email,
  //     'password': pwd,
  //     'returnSecureToken': true
  //   };
  //   final http.Response authResponse = await http.post(
  //       'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
  //       body: json.encode(authData),
  //       headers: {'Content-type': 'application/json'});
  //   if (authResponse == null) {
  //     var msg = 'An Error Occured while Authentication.';
  //     return {"success": false, "msg": msg};
  //   }

  //   var authResponseBody = json.decode(authResponse.body);

  //   _authProgess = false;
  //   notifyListeners();

  //   if (authResponse.statusCode != 200) {
  //     var msg = 'An Error Occured while Authentication.';
  //     switch (authResponseBody['error']['message']) {
  //       case 'EMAIL_EXISTS':
  //         msg = 'Given email already exists.';
  //         break;
  //       case 'OPERATION_NOT_ALLOWED':
  //         msg =
  //             'We cannot process your request. Please try again another Authentication method.';
  //         break;
  //       case 'TOO_MANY_ATTEMPTS_TRY_LATER':
  //         msg = 'Max attempts reached. Please try again after some time.';
  //         break;
  //     }
  //     return {"success": false, "msg": msg};
  //   }
  //   _loggedInUser = User(
  //       email: authResponseBody["email"],
  //       id: authResponseBody["localId"],
  //       idToken: authResponseBody["idToken"]);
  //   if (authResponseBody["idToken"] == null) {
  //     return {"success": false};
  //     //@todo - rollback signup process, to make email available for signup
  //   }
  //   return {"success": true};
  // }

  getUserDetails() {
    return _loggedInUser.details;
  }
}

mixin ProductsScopedModel on ConnectedScopedModel {
  bool _fetchingProducts = false;
  // User user = ConnectedScopedModel.user;
  get loadingProducts => _fetchingProducts;
  bool _addProductProgress = false;
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
    if (id != null) {
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
    http.Response deleted = await http
        .delete(
            'https://flutter-udemy-course-practice.firebaseio.com/products/$id.json?auth=${_loggedInUser.idToken}')
        .catchError((err) => print(err));
// if(!(deleted)){
//   // _deleteFail = true;
// }

    if (deleted.statusCode != 200 || deleted.statusCode != 201) {
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
    item['createdBy'] = _loggedInUser.id;
    notifyListeners();
    http.Response addItemResponse = await http
        .post(
            'https://flutter-udemy-course-practice.firebaseio.com/products.json?auth=${_loggedInUser.idToken}',
            body: json.encode(item))
        .catchError((err) {
      print(err);
    });

    if (addItemResponse.statusCode != 200 &&
        addItemResponse.statusCode != 201) {
      _addProductProgress = false;
      notifyListeners();
      return false;
    }
    Map<String, dynamic> addItemResponseMap = json.decode(addItemResponse.body);
    item["id"] = addItemResponseMap['name'];
    Product product = Product(
      createdBy: item['createdBy'],
        title: item['title'],
        price: item['price'],
        description: item['description'],
        imgUrl: item['imgUrl'],
        isFavourite: false,
        id: addItemResponseMap['name']);
    _items.add(product);
    _addProductProgress = false;
    notifyListeners();
    return true;
  }

  Future<Null> editProduct(
      String id, Map<String, dynamic> changedValues) async {
        var product = getProduct(id);
    var newValues = {
      "title": changedValues['title'],
      "price": changedValues['price'],
      "description": changedValues['description'],
      "imgUrl": changedValues['img'] == '' ? getProduct(id).imgUrl : changedValues['img'],
      "createdBy":getProduct(id).createdBy,
      "wishListedUsers":product.wishListedUsers
    };

    http.Response updated = await http
        .put(
            "https://flutter-udemy-course-practice.firebaseio.com/products/$id.json?auth=${_loggedInUser.idToken}",
            body: json.encode(newValues))
        .catchError((err) => print(err));

    print(updated);

    int index = _items.indexWhere((item) => item.id == id);
    _items[index] = Product(
        id: id,
        title: newValues['title'],
        price: newValues['price'],
        description: newValues['description'],
        imgUrl: newValues['imgUrl'],
        isFavourite:product.wishListedUsers ? product.wishListedUsers.containsKey(_loggedInUser.id) : false,
        wishListedUsers:product.wishListedUsers);
    notifyListeners();
  }

  Product getProduct(id) {
    return _items.firstWhere((p) => p.id == id, orElse: () => null);
  }

  void favouriteProduct(id) async{
    getProduct(id).favouriteProduct();
    notifyListeners();
    final updateResponse = await http.put('https://flutter-udemy-course-practice.firebaseio.com/products/${id}/wishListedUsers/${_loggedInUser.id}.json?auth=${_loggedInUser.idToken}',body: jsonEncode(true));
    if(updateResponse == null || (updateResponse.statusCode != 200 && updateResponse.statusCode != 201)){
      getProduct(id).unFavouriteProduct();
      print(jsonDecode(updateResponse.body).error);
      print('could not favourite, rolling back');
      return notifyListeners();
    }
    print('succesfuly favourited');
  }

  void unFavouriteProduct(id) async{
    getProduct(id).unFavouriteProduct();
    notifyListeners();
    //send req
    final updateResponse = await http.delete('https://flutter-udemy-course-practice.firebaseio.com/products/$id/wishListedUsers/${_loggedInUser.id}.json?auth=${_loggedInUser.idToken}');
    if(updateResponse == null || (updateResponse.statusCode != 200 && updateResponse.statusCode != 201) ){
      getProduct(id).favouriteProduct();
      print(jsonDecode(updateResponse.body).error);
      print('could not unfavourite, rolling back');
      return notifyListeners();
    }
    print('successfully updated status');
  }

  void toggleFavourites() {
    showFavourites = !showFavourites;
    notifyListeners();
  }

  Future<bool> fetchProducts({bool pullRefresh: false,bool thisUserProductsOnly :false}) async {
    if (!pullRefresh) {
      _fetchingProducts = true;
      notifyListeners();
    }
    http.Response fetchProductsResponse = await http
        .get(
            'https://flutter-udemy-course-practice.firebaseio.com/products.json?auth=${_loggedInUser.idToken}')
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
    (fetchProductsResponseBody ??= {})
        .forEach((String productFirebaseId, dynamic item) {
      fetchedProducts.add(
        Product(
          createdBy:item['createdBy'],
            id: productFirebaseId,
            price: item['price'],
            title: item['title'],
            imgUrl: item['imgUrl'],
            isFavourite: item['wishListedUsers'] != null ? item['wishListedUsers'].containsKey(_loggedInUser.id) : false,
            description: item['description'],
            wishListedUsers:item['wishListedUsers'],
            ),
      );
    });
    _items = thisUserProductsOnly  ? fetchedProducts.where((p)=>p.createdBy == _loggedInUser.id).toList() : fetchedProducts;
    _fetchingProducts = false;
    notifyListeners();
    return true;
  }
}
