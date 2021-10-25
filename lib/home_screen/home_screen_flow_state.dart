import 'package:equatable/equatable.dart';
import 'package:reap_book/model/user.dart';

class HomeScreenFlowState extends Equatable {
  @override
  List<Object> get props => [];

}

class InitApp extends HomeScreenFlowState {}

class FetchingUsers extends HomeScreenFlowState {}

class PostFetchedUsers extends HomeScreenFlowState {
  final List<User> users;

  PostFetchedUsers(this.users);
}

class FetchingUsersListFailed extends HomeScreenFlowState {
  final String message;

  FetchingUsersListFailed(this.message);
}
