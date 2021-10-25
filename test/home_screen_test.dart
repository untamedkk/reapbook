import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../lib/api/api_provider.dart';
import '../lib/api/api_repository.dart';
import '../lib/home_screen/home_screen_bloc.dart';

class MockApiProvider extends Mock implements ApiProvider {}

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  MockApiProvider apiProvider;
  MockApiRepository apiRepository;
  HomeScreenBloc homeScreenBloc;

  setUp(() {
    apiProvider = MockApiProvider();
    apiRepository = MockApiRepository();
    homeScreenBloc = HomeScreenBloc(apiRepository);
  });

  tearDown(() {
    homeScreenBloc.close();
  });
}
