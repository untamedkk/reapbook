import 'package:equatable/equatable.dart';

class CreatePostRequest extends Equatable {
  final String title;
  final String body;
  final int userId;

  CreatePostRequest(this.title, this.body, this.userId);

  @override
  List<Object> get props => [title, body, userId];

  Map<String, dynamic> toJson() => {'title': title, 'body': body, 'userId': userId};
}
