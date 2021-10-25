import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reap_book/api/api_provider.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/user_photos_screen/user_photos_screen.dart';
import 'package:reap_book/utils/alert_dialogs.dart';
import 'package:reap_book/widgets/loading_widget.dart';

import 'user_albums_bloc.dart';
import 'user_albums_event.dart';
import 'user_albums_state.dart';

class UserAlbumsWidget extends StatefulWidget {
  final int userId;

  UserAlbumsWidget(this.userId);

  @override
  State<StatefulWidget> createState() => _UserAlbumsWidgetState();
}

class _UserAlbumsWidgetState extends State<UserAlbumsWidget>
    with AutomaticKeepAliveClientMixin<UserAlbumsWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ApiRepository>(
        create: (context) {
          return ApiRepository(ApiProvider());
        },
        child: BlocProvider<UserAlbumsBloc>(
          create: (context) {
            final _apiRepository =
                RepositoryProvider.of<ApiRepository>(context);
            return UserAlbumsBloc(_apiRepository)
              ..add(FetchUserAlbum(widget.userId));
          },
          child: BlocConsumer<UserAlbumsBloc, UserAlbumsState>(
              listener: (context, state) {
            if (state is FetchingUserAlbumsFailed) {
              AlertDialogs.showErrorDialog(context,
                  onClickAction: () => {
                        BlocProvider.of<UserAlbumsBloc>(context)
                            .add(FetchUserAlbum(widget.userId))
                      });
            }
          }, builder: (context, state) {
            if (state is PostFetchUserAlbums) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: state.albums.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () =>
                            UserPhotosScreen.open(context, state.albums[index]),
                        child: Card(
                          color: Colors.white30,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_special_outlined,
                                size: 50,
                              ),
                              Center(
                                child: Text(
                                  state.albums[index].title,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            } else {
              return LoadingWidget();
            }
          }),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
