import 'package:scoped_model/scoped_model.dart';

import '../models/Product.dart';

class ProductsScopedModel extends Model {
  List<Product> _items = [
    Product(
        id: "1",
        title: 'Sweet',
        imgUrl: 'assets/images/sweet.jpg',
        price: 200.0,
        description: 'Delicious. or is it?'),
    Product(
        id: "1",
        title: 'Chutney',
        imgUrl: 'assets/images/chutney.jpg',
        price: 35.0,
        description: 'Tasty. isn\'t it?')
  ];

  int _selectedProductId;

  setSelectedProductIndex(id) {
    return _selectedProductId = id;
  }

  int get selectedProductId => _selectedProductId;

  List<Product> get products => _items;

  void clearItems() {
  
      {
        _items = [];
        print(_items);
      }
  }

  void deleteItem(String id) {
    _items = _items.where((item) => item.id != id).toList();
    // _items.removeWhere((item)=>item['id'] == id)
    print(_items);
  }

  void addItem(Product item) {
    var lastItem = _items.last;
    var lastId = lastItem != null ? lastItem.id : 0;
    item.id = (int.parse(lastId) + 1).toString();
    _items.add(item);
    print(_items);
  }

  void editProduct(String id, Map<String, dynamic> changedValues) {
    _items.removeWhere((item) => item.id == id);
    _items.add(Product(
        id: id,
        title: changedValues['title'],
        price: changedValues['price'],
        description: changedValues['description'],
        imgUrl: changedValues['img']));
  }

  Product getProduct(id){
    return _items.firstWhere((p)=>p.id == id);
  }
}
