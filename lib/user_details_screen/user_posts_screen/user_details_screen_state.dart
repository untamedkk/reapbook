import 'package:equatable/equatable.dart';
import 'package:reap_book/model/post.dart';

class UserDetailsScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchingUserPost extends UserDetailsScreenState {}

class PostFetchUserPost extends UserDetailsScreenState {
  final List<Post> posts;

  PostFetchUserPost(this.posts);
}

class FetchingUsersPostFailed extends UserDetailsScreenState {
  final String message;

  FetchingUsersPostFailed(this.message);
}

class CreatePostSuccessful extends UserDetailsScreenState {
  final Post post;

  CreatePostSuccessful(this.post);
}

class UpdatePostSuccessful extends UserDetailsScreenState with EquatableMixin {
  final Post post;

  UpdatePostSuccessful(this.post);

  @override
  List<Object> get props => [post];
}

class UpdatePostFailed extends UserDetailsScreenState with EquatableMixin {
  final String message;

  UpdatePostFailed(this.message);

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}

class DeletePostSuccessful extends UserDetailsScreenState with EquatableMixin {
  DeletePostSuccessful();

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}

class DeletePostFailed extends UserDetailsScreenState with EquatableMixin {
  final String message;

  DeletePostFailed(this.message);

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}

class CreatePostFailed extends UserDetailsScreenState with EquatableMixin {
  final String message;

  CreatePostFailed(this.message);

  @override
  List<Object> get props => [message];
}

class UpdatePostList extends UserDetailsScreenState {
  UpdatePostList();
}
