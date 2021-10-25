import 'package:reap_book/model/post.dart';

class UserPostResponse {
  List<Post> posts;

  UserPostResponse.fromJson(List<dynamic> json) : this.posts = [] {
    List<Post> c = json.map((userJson) => Post.fromJson(userJson)).toList();
    this.posts.addAll(c);
  }
}