import 'package:bloc/bloc.dart';
import 'package:reap_book/api/api_repository.dart';

import 'home_screen_flow_event.dart';
import 'home_screen_flow_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenFlowEvent, HomeScreenFlowState> {
  final ApiRepository _apiRepository;

  HomeScreenBloc(this._apiRepository);

  @override
  HomeScreenFlowState get initialState => InitApp();

  @override
  Stream<HomeScreenFlowState> mapEventToState(
      HomeScreenFlowEvent event) async* {
    if (event is FetchUsers) {
      yield FetchingUsers();
      try {
        var response = await _apiRepository.getUsers();
        yield PostFetchedUsers(response);
      } catch (err) {
        yield FetchingUsersListFailed(err.toString());
      }
    }
  }
}
