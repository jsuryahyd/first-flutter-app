import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';
// import 'dart:async';
///
/// product edit and create
///
class ProductInputPage extends StatefulWidget {
  ProductInputPage();
  @override
  State<StatefulWidget> createState() {
    return ProductInputPageState();
  }
}

class ProductInputPageState extends State<ProductInputPage> {
  Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': null,
    'img': 'assets/images/sweet.jpg'
  };
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Widget build(context) {
    return new ScopedModelDescendant<AppScopedModel>(
      builder: (BuildContext context, Widget child, AppScopedModel model) {
        //edit mode
        if (model.selectedProductId != null) {
          return new Scaffold(
              appBar: AppBar(
                title: Text("Edit Product"),
              ),
              body: this.pageContent(
                  product: model.getProduct(model.selectedProductId),
                  addItem: model.addItem,
                  editProduct: model.editProduct,
                  resetSelectedProductId: model.setSelectedProductId),);
        }
        return this.pageContent(addItem: model.addItem,addProductProgress:model.addProductProgress);
      },
    );
  }

  Widget pageContent(
      {product,
      addItem,
      editProduct,
      resetSelectedProductId,
      addProductProgress}) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double formWidth =
        deviceWidth > 550.0 ? deviceWidth * 0.6 : deviceWidth * 0.9;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: formWidth,
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              _buildTitleInput(product?.title),
              _buildDescriptionInput(product?.description),
              _buildPriceInput(product?.price),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(product?.id,
                  addItem: addItem,
                  editProduct: editProduct,
                  resetSelectedProductId: resetSelectedProductId,addProductProgress:addProductProgress),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput(productTitle) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: productTitle != null ? productTitle : '',
      autocorrect: true,
      validator: (String value) {
        if (value.trim() == '') {
          return "Enter the title, dummy!";
        }
      },
      onSaved: (String inputValue) {
        _formData['title'] = inputValue;
      },
    );
  }

  Widget _buildDescriptionInput(productDesc) {
    return TextFormField(
      initialValue: productDesc != null ? productDesc : '',
      decoration: InputDecoration(labelText: 'Product Description'),
      validator: (String value) {
        if (value.trim().isEmpty || value.trim().length <= 10) {
          return 'Description is Required and must have 10+ characters';
        }
      },
      maxLines: 4,
      onSaved: (String inputValue) {
        _formData['description'] = inputValue;
      },
    );
  }

  Widget _buildPriceInput(productPrice) {
    return TextFormField(
      initialValue: productPrice != null ? productPrice.toString() : '',
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.trim().isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value.trim())) {
          return 'Price is Required and should be a number.';
        }
      },
      onSaved: (String inputValue) {
        _formData['price'] = double.parse(inputValue);
      },
    );
  }

  Widget _buildSubmitButton(editableProductId,
      {addItem, editProduct, resetSelectedProductId, addProductProgress}) {
    return addProductProgress == true ? Center(
            child: CircularProgressIndicator(),
          )
        : RaisedButton(
            onPressed: () => submitForm(addItem, editProduct, editableProductId,
                resetSelectedProductId),
            child: Text(
                editableProductId != null ? 'Edit Product' : 'Add Product'),
            color: Theme.of(context).accentColor,
          );
  }

  submitForm(Function addProduct, Function editProduct, editableProductId,
      resetSelectedProductId) async {
    if (!_globalKey.currentState.validate()) {
      return false;
    }
    _globalKey.currentState.save();
    if (editableProductId != null) {
      editProduct(editableProductId, _formData);
      Navigator.pushReplacementNamed(context, '/productsPage');
    
    } else {
      addProduct({
              "title": _formData['title'],
              "price": _formData['price'],
              "description": _formData['description'],
              "imgUrl": _formData['img']})
          .then((bool success) =>
              Navigator.pushReplacementNamed(context, '/productsPage')
                  .then((_) {
                resetSelectedProductId(null);
              }));
    }
  }
}
