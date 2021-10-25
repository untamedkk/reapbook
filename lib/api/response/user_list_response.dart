import 'package:reap_book/model/user.dart';

class UserListResponse {
  List<User> results;

  UserListResponse.fromJson(List<dynamic> json) : this.results = [] {
    List<User> c = json.map((userJson) => User.fromJson(userJson)).toList();
    this.results.addAll(c);
  }
}
