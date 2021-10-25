import 'package:bloc/bloc.dart';
import 'package:reap_book/api/api_repository.dart';

import 'user_photos_event.dart';
import 'user_photos_state.dart';

class UserPhotosBloc extends Bloc<UserPhotosEvent, UserPhotosState> {
  final ApiRepository _apiRepository;

  UserPhotosBloc(this._apiRepository);

  @override
  UserPhotosState get initialState => FetchingUserPhotos();

  @override
  Stream<UserPhotosState> mapEventToState(UserPhotosEvent event) async* {
    if (event is FetchUserPhotos) {
      yield FetchingUserPhotos();
      try {
        var response = await _apiRepository.getPhoto(event.id);
        yield PostFetchUserPhotos(response);
        return;
      } catch (err) {
        yield FetchingUserPhotosFailed(err.toString());
        return;
      }
    }
  }
}
