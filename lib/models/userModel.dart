import 'package:meta/meta.dart';

class User {
  final String id;
  final String email;
final String idToken;
User({@required this.id,@required this.email,@required this.idToken});


Map get details => {"id":id,"email":email,idToken:idToken};
}