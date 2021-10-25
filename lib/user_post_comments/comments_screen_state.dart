import 'package:equatable/equatable.dart';
import 'package:reap_book/model/comment.dart';

class CommentsScreenState extends Equatable {
  @override
  List<Object> get props => [];

}

class FetchingComments extends CommentsScreenState {

}

class PostFetchComments extends FetchingComments {
  final List<Comment> comments;

  PostFetchComments(this.comments);
}

class FetchingCommentsFailed extends FetchingComments {
  final String message;

  FetchingCommentsFailed(this.message);
}