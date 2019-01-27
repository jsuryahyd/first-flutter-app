// import './scope_model/products.dart';
// import './scope_model/userScopedModel.dart';
// import 'package:scoped_model/scoped_model.dart';
// class AppScopedModel extends Model with UserScopedModel,ProductsScopedModel{

// }
import 'package:scoped_model/scoped_model.dart';
import './scope_model/connectedScopedModel.dart';
class AppScopedModel extends Model with ConnectedScopedModel,UserScopedModel,ProductsScopedModel{

}