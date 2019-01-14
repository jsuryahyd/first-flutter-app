import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../appScopedModel.dart';
import '../models/authModel.dart';

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
  AuthMode _authMode = AuthMode.login;
  final TextEditingController _pwdController = TextEditingController();
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
                        controller: _pwdController,
                        onSaved: (String pwdInput) {
                          _pwdInput = pwdInput;
                        },
                        validator: (String value) {
                          if (value.isEmpty || value.length < 8) {
                            return 'Password must not be empty and must contain atleast 8 characters.';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Theme.of(context).accentColor),
                      ),
                      _confirmPwdField(),
                      _authMode == AuthMode.login ? Container() : SwitchListTile(
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
                      FlatButton(
                        child: Text(
                            "Switch to ${_authMode == AuthMode.login ? 'Signup' : 'Login'}"),
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.login
                                ? AuthMode.signup
                                : AuthMode.login;
                          });
                        },
                      ),
                      ScopedModelDescendant(
                        builder: (BuildContext context, Widget child,
                            AppScopedModel model) {
                          return model.authProgress ? Center(child:CircularProgressIndicator()) : RaisedButton(
                            onPressed: () {
                              _loginFormKey.currentState.save();
                              if (!_loginFormKey.currentState.validate()) {
                                return false;
                              }
                              _authenticate(model.authenticate,_authMode);
                            },
                            child: Text(_authMode == AuthMode.login
                                ? 'Login'.toUpperCase()
                                : 'Signup'.toUpperCase()),
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

  _confirmPwdField() {
    return _authMode == AuthMode.signup
        ? Column(children: [
            SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              onSaved: (String pwdInput) {},
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Password must not be empty and must contain atleast 8 characters.';
                }
                if (value != _pwdController.text) {
                  return 'Passwords doesn\'t match';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  fillColor: Theme.of(context).accentColor),
            ),
          ])
        : Container();
  }

  _authenticate(authFunc,authMode) async {
    final Map<String, dynamic> loginData =
        await authFunc(_emailInput, _pwdInput,authMode).catchError((err) {
      print(err);
    });
    if (loginData == null || !loginData['success'])
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text(loginData != null
                  ? loginData["msg"]
                  : 'An Error occured while authenticating.'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
    Navigator.pushReplacementNamed(context, 'ProductsPage');
  }

  // _signup(signUp) async {
  //   if(_acceptTerms != true){
  //     return false;
  //   }
  //   final Map<String, dynamic> signupData = await signUp(_emailInput, _pwdInput).catchError((err) {
  //     print(err);
  //   });
  //   if (signupData == null || !signupData['success'])
  //     return showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Signup Failed'),
  //             content: Text(signupData != null
  //                 ? signupData["msg"]
  //                 : 'An Error occured while authenticating.'),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Ok'),
  //               ),
  //             ],
  //           );
  //         });
  //   Navigator.pushReplacementNamed(context, 'ProductsPage');
  // }
}
