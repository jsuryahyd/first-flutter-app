import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String _emailInput = '';
  String _pwdInput = '';
  double _formWidth = 300.0; //default
  bool _acceptTerms = false;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    _formWidth = deviceWidth > 550.0 ? deviceWidth * 0.6 : deviceWidth * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black38, BlendMode.dstATop))),
        child: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: _formWidth,
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String emailInput) {
                          _emailInput = emailInput;
                        },
                        validator: (String value) {
                          if (value.trim().isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(value.trim())) {
                            return 'Please enter a valid Email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            filled: true,
                            fillColor: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (String pwdInput) {
                          _pwdInput = pwdInput;
                        },
                        validator: (String value) {
                          if (value.isEmpty || value.length <= 8) {
                            return 'Password must contain atleast one capital letter and one number.';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Theme.of(context).accentColor),
                      ),
                      SwitchListTile(
                        value: _acceptTerms,
                        onChanged: (bool isSwitched) {
                          setState(() {
                            _acceptTerms = isSwitched;
                          });
                        },
                        title: Text('Read and Accept Our Terms & Conditions'),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ScopedModelDescendant(
                        builder: (BuildContext context, Widget child,
                            AppScopedModel model) {
                          return RaisedButton(
                            onPressed: () {
                              _loginFormKey.currentState.save();
                              model.login(_emailInput, _pwdInput);
                              if (_loginFormKey.currentState.validate() &&
                                  _acceptTerms == true) {
                                Navigator.pushReplacementNamed(
                                    context, 'ProductsPage');
                              }
                            },
                            child: Text('Login'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
