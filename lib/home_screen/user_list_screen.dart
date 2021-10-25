import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reap_book/api/api_provider.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/home_screen/home_screen_bloc.dart';
import 'package:reap_book/home_screen/home_screen_flow_event.dart';
import 'package:reap_book/home_screen/home_screen_flow_state.dart';
import 'package:reap_book/utils/alert_dialogs.dart';
import 'package:reap_book/widgets/loading_widget.dart';
import 'package:reap_book/widgets/users_list_widget.dart';

class PeopleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ApiRepository>(
      create: (context) {
        return ApiRepository(ApiProvider());
      },
      child: BlocProvider<HomeScreenBloc>(
        create: (context) {
          final _apiRepository = RepositoryProvider.of<ApiRepository>(context);
          return HomeScreenBloc(_apiRepository)..add(FetchUsers());
        },
        child: BlocConsumer<HomeScreenBloc, HomeScreenFlowState>(
          listener: (context, state) {
            if (state is FetchingUsersListFailed) {
              AlertDialogs.showErrorDialog(context,
                  onClickAction: () => {
                        BlocProvider.of<HomeScreenBloc>(context)
                            .add(FetchUsers())
                      });
            }
          },
          builder: (context, state) {
            if (state is FetchingUsers) {
              return LoadingWidget();
            } else if (state is PostFetchedUsers) {
              return UsersListWidget(state.users);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
