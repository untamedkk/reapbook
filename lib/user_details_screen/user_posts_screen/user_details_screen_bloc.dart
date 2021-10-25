import 'package:bloc/bloc.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/api/request/create_post_request.dart';
import 'package:reap_book/api/request/update_post_request.dart';

import 'user_details_screen_event.dart';
import 'user_details_screen_state.dart';

class UserDetailsScreenBloc
    extends Bloc<UserDetailsScreenEvent, UserDetailsScreenState> {
  final ApiRepository _apiRepository;

  UserDetailsScreenBloc(this._apiRepository);

  @override
  UserDetailsScreenState get initialState => FetchingUserPost();

  @override
  Stream<UserDetailsScreenState> mapEventToState(
      UserDetailsScreenEvent event) async* {
    if (event is FetchUserPost) {
      yield FetchingUserPost();
      try {
        var response = await _apiRepository.getUserPosts(event.id);
        yield PostFetchUserPost(response);
        return;
      } catch (err) {
        yield FetchingUsersPostFailed(err.toString());
        return;
      }
    }

    if (event is CreatePost) {
      try {
        var createPostRequest =
            CreatePostRequest(event.title, event.body, event.userId);
        final response = await _apiRepository.createPost(createPostRequest);
        yield CreatePostSuccessful(response);
        return;
      } catch (err) {
        yield CreatePostFailed(err.toString());
        return;
      }
    }

    if (event is UpdatePost) {
      try {
        var updatePostRequest =
            UpdatePostRequest(event.title, event.body, event.userId, event.id);
        final response = await _apiRepository.updatePost(updatePostRequest);
        yield UpdatePostSuccessful(response);
        return;
      } catch (err) {
        yield UpdatePostFailed(err.toString());
        return;
      }
    }

    if (event is DeletePost) {
      try {
        final response = await _apiRepository.deletePost(event.id);
        yield DeletePostSuccessful();
        return;
      } catch (err) {
        yield DeletePostFailed(err.toString());
        return;
      }
    }

    if (event is UpdateNewPost) {
      yield UpdatePostList();
      return;
    }
  }
}
