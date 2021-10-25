import 'package:equatable/equatable.dart';

class CommentsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserComments extends CommentsScreenEvent {
  final int id;

  FetchUserComments(this.id);
}
