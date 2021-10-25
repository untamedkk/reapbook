import 'package:reap_book/model/comment.dart';

class CommentsListResponse {
  List<Comment> comments;

  CommentsListResponse.fromJson(List<dynamic> json) : this.comments = [] {
    List<Comment> c =
        json.map((userJson) => Comment.fromJson(userJson)).toList();
    this.comments.addAll(c);
  }
}
