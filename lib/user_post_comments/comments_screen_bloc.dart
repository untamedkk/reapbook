import 'package:bloc/bloc.dart';
import 'package:reap_book/api/api_repository.dart';

import 'comments_screen_event.dart';
import 'comments_screen_state.dart';

class CommentsScreenBloc
    extends Bloc<CommentsScreenEvent, CommentsScreenState> {
  final ApiRepository _apiRepository;

  CommentsScreenBloc(this._apiRepository);

  @override
  CommentsScreenState get initialState => FetchingComments();

  @override
  Stream<CommentsScreenState> mapEventToState(
      CommentsScreenEvent event) async* {
    if (event is FetchUserComments) {
      yield FetchingComments();
      try {
        var response = await _apiRepository.getComment(event.id);
        yield PostFetchComments(response);
      } catch (err) {
        yield FetchingCommentsFailed(err.toString());
      }
    }
  }
}
