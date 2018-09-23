import 'package:flutter/material.dart';

import './ProductsListPage.dart';

class AuthPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Center(child:RaisedButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
            return ProductsListPage();
          }),);
        },
        child:Text('Login')
      )),
    );
  }
}
