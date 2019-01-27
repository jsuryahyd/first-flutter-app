import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../appScopedModel.dart';

class LogoutListTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant(
      builder: (BuildContext context,Widget child,AppScopedModel model){
return ListTile(
  title:Text('Logout'),
  leading: Icon(Icons.exit_to_app),
  onTap: (){
    model.logout();
    Navigator.pushReplacementNamed(context, '/');
  },
);
      },
    );
  }

}