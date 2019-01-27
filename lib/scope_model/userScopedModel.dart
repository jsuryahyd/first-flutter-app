import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/userModel.dart';
import '../models/authModel.dart';

import './connectedScopedModel.dart';

mixin UserScopedModel on ConnectedScopedModel {
  User _loggedInUser;
  bool _authProgess = false; 
  get authProgress =>  _authProgess;
  get user => _loggedInUser;
  Future<Map<String, dynamic>> authenticate(String email, String pwd,[authMode=AuthMode.login]) async {
    this._authProgess = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': pwd,
      'returnSecureToken': true
    };

    final http.Response authResponse = authMode == AuthMode.login  ? await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
        body: json.encode(authData),
        headers: {'Content-type': 'application/json'}):  await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
        body: json.encode(authData),
        headers: {'Content-type': 'application/json'});;
    if (authResponse == null) {
      return {
        "success": false,
        "msg": 'An Error Occured while Authentication.'
      };
    }
    var authResponseBody = json.decode(authResponse.body);
    _authProgess = false;
    print('response -- ' + jsonEncode(authResponseBody));
    notifyListeners();
    if (authResponse.statusCode != 200) {
      var msg = 'An Error Occured while Authentication.';
      switch (authResponseBody['error']['message']) {
        case 'EMAIL_NOT_FOUND':
          msg = 'Given email doesnot exist.';
          break;
        case 'INVALID_PASSWORD':
          msg = 'Authentication Failed.';
          break;
        case 'USER_DISABLED':
          msg = 'Access Denied.';
          break;
          case 'EMAIL_EXISTS':
          msg = 'Given email already exists.';
          break;
        case 'OPERATION_NOT_ALLOWED':
          msg =
              'We cannot process your request. Please try again another Authentication method.';
          break;
        case 'TOO_MANY_ATTEMPTS_TRY_LATER':
          msg = 'Max attempts reached. Please try again after some time.';
          break;
      }
      return {"success": false, "msg": msg};
    }
    _loggedInUser = User(
        email: authResponseBody["email"],
        id: authResponseBody["localId"],
        idToken: authResponseBody["idToken"]);
    if (authResponseBody["idToken"] == null) {
      return {"success": false};
    }
    return {"success": true};
  }

  // Future<Map<String, dynamic>> signup(String email, String pwd) async {
  //   _authProgess = true;
  //   notifyListeners();
  //   final Map<String, dynamic> authData = {
  //     'email': email,
  //     'password': pwd,
  //     'returnSecureToken': true
  //   };
  //   final http.Response authResponse = await http.post(
  //       'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC1usEpZ6h24OE3HNznBy5O7E5DE5mECiw',
  //       body: json.encode(authData),
  //       headers: {'Content-type': 'application/json'});
  //   if (authResponse == null) {
  //     var msg = 'An Error Occured while Authentication.';
  //     return {"success": false, "msg": msg};
  //   }

  //   var authResponseBody = json.decode(authResponse.body);

  //   _authProgess = false;
  //   notifyListeners();

  //   if (authResponse.statusCode != 200) {
  //     var msg = 'An Error Occured while Authentication.';
  //     switch (authResponseBody['error']['message']) {
  //       case 'EMAIL_EXISTS':
  //         msg = 'Given email already exists.';
  //         break;
  //       case 'OPERATION_NOT_ALLOWED':
  //         msg =
  //             'We cannot process your request. Please try again another Authentication method.';
  //         break;
  //       case 'TOO_MANY_ATTEMPTS_TRY_LATER':
  //         msg = 'Max attempts reached. Please try again after some time.';
  //         break;
  //     }
  //     return {"success": false, "msg": msg};
  //   }
  //   _loggedInUser = User(
  //       email: authResponseBody["email"],
  //       id: authResponseBody["localId"],
  //       idToken: authResponseBody["idToken"]);
  //   if (authResponseBody["idToken"] == null) {
  //     return {"success": false};
  //     //@todo - rollback signup process, to make email available for signup
  //   }
  //   return {"success": true};
  // }

  getUserDetails() {
    return _loggedInUser.details;
  }
}


