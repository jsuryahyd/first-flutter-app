import 'package:scoped_model/scoped_model.dart';
import '../models/userModel.dart';

mixin UserScopedModel on Model {
  User _loggedInUser;

  void login(String email, String pwd) {
    _loggedInUser = User(email: email, id: '1');
  }

  getUserDetails(){
    return _loggedInUser.details;
  }
}
