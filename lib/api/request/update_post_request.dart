import 'package:equatable/equatable.dart';

class UpdatePostRequest extends Equatable {
  final String title;
  final String body;
  final int userId;
  final int id;

  UpdatePostRequest(this.title, this.body, this.userId, this.id);

  @override
  List<Object> get props => [title, body, userId];

  Map<String, dynamic> toJson() =>
      {'title': title, 'body': body, 'userId': userId, 'id': id};
}
