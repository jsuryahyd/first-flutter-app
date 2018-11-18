import 'package:flutter/material.dart';

class ClearItemsButton extends StatelessWidget {
  final clickFunc;
  ClearItemsButton(this.clickFunc);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Clear Items'),
      onPressed: () {
        clickFunc();
      },
    );
  }
}
