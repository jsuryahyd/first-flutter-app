import 'package:flutter/material.dart';


class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return AuthPageState();
    }
}

class AuthPageState extends State<AuthPage>{
  String _emailInput = '';
  String _pwdInput ='';
  bool _acceptTerms = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Container(margin:EdgeInsets.fromLTRB(25.0, 150.0, 25.0, 25.0),child:ListView(children: <Widget>[
        TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (String emailInput)=>
            setState((){
              _emailInput =  emailInput;
            }),
            decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          obscureText:true,
          onChanged: (String pwdInput)=>
            setState((){
              _pwdInput =  pwdInput;
            }),
            decoration: InputDecoration(labelText: 'Password'),
        ),
        SwitchListTile(value: _acceptTerms,onChanged: (bool isSwitched){
          setState(() {
                      _acceptTerms = isSwitched;
                    });
        },title:Text('Read and Accept Our Terms & Conditions'),),
        SizedBox(height: 30.0,),
        
        RaisedButton(
        onPressed: (){
          if(_emailInput != '' && _pwdInput != '' && _acceptTerms){
          Navigator.pushReplacementNamed(context,'ProductsPage');
          }
        },
        child:Text('Login')
      )
      ],),),
    );
  }
}
