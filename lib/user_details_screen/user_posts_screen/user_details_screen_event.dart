import 'package:equatable/equatable.dart';

class UserDetailsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserPost extends UserDetailsScreenEvent {
  final int id;

  FetchUserPost(this.id);
}

class CreatePost extends UserDetailsScreenEvent {
  final String body;
  final String title;
  final int userId;

  CreatePost(this.body, this.title, this.userId);
}

class UpdatePost extends UserDetailsScreenEvent {
  final String body;
  final String title;
  final int userId;
  final int id;

  UpdatePost(this.body, this.title, this.userId, this.id);
}

class DeletePost extends UserDetailsScreenEvent {
  final int id;

  DeletePost(this.id);
}

class UpdateNewPost extends UserDetailsScreenEvent {
  UpdateNewPost();
}
