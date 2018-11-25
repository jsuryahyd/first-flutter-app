import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String _emailInput = '';
  String _pwdInput = '';
  bool _acceptTerms = false;
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String emailInput) => setState(() {
                        _emailInput = emailInput;
                      }),
                  decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (String pwdInput) => setState(() {
                        _pwdInput = pwdInput;
                      }),
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
                RaisedButton(
                    onPressed: () {
                      if (_emailInput != '' &&
                          _pwdInput != '' &&
                          _acceptTerms) {
                        Navigator.pushReplacementNamed(context, 'ProductsPage');
                      }
                    },
                    child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
