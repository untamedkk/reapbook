import 'package:bloc/bloc.dart';
import 'package:reap_book/api/api_repository.dart';

import 'user_albums_event.dart';
import 'user_albums_state.dart';

class UserAlbumsBloc extends Bloc<UserAlbumsEvent, UserAlbumsState> {
  final ApiRepository _apiRepository;

  UserAlbumsBloc(this._apiRepository);

  @override
  UserAlbumsState get initialState => FetchingUserAlbums();

  @override
  Stream<UserAlbumsState> mapEventToState(UserAlbumsEvent event) async* {
    if (event is FetchUserAlbum) {
      yield FetchingUserAlbums();
      try {
        var response = await _apiRepository.getAlbums(event.id);
        yield PostFetchUserAlbums(response);
        return;
      } catch (err) {
        yield FetchingUserAlbumsFailed(err.toString());
        return;
      }
    }
  }
}
