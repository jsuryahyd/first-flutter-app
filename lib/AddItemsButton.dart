import 'package:flutter/material.dart';

class AddItemsButton extends StatelessWidget{
  final clickFunc;
  AddItemsButton(this.clickFunc);
  
  @override
  Widget build(BuildContext context){
    return RaisedButton(
                  child: Text('Clear Items'),
                  onPressed: () {
                    clickFunc();
                  },
                );
  }
}