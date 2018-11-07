import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Center(child:RaisedButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context,'ProductsPage');
        },
        child:Text('Login')
      )),
    );
  }
}
