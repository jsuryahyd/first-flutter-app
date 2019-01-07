import 'package:meta/meta.dart';

class User {
  final String id;
  final String email;

User({@required this.id,@required this.email});


Map get details => {"id":id,"email":email};
}