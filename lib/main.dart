import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override //overrides the build method of StatelessWidget class
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body:Card(child: Column(children:<Widget>[
Image.asset('assets/traditional-lunch.jpg'),
Text('Food Paradise')
        ]),)
      ),
    );
  }
}
