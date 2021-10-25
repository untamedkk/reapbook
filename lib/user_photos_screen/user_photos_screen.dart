import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reap_book/api/api_provider.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/model/album.dart';
import 'package:reap_book/user_photos_screen/full_screen_image_screen.dart';
import 'package:reap_book/utils/alert_dialogs.dart';
import 'package:reap_book/widgets/loading_widget.dart';

import 'user_photos_bloc.dart';
import 'user_photos_event.dart';
import 'user_photos_state.dart';

class UserPhotosScreen extends StatelessWidget {
  final Album album;

  UserPhotosScreen(this.album);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: RepositoryProvider<ApiRepository>(
          create: (context) {
            return ApiRepository(ApiProvider());
          },
          child: BlocProvider<UserPhotosBloc>(
            create: (context) {
              final _apiRepository =
                  RepositoryProvider.of<ApiRepository>(context);
              return UserPhotosBloc(_apiRepository)
                ..add(FetchUserPhotos(album.id));
            },
            child: BlocConsumer<UserPhotosBloc, UserPhotosState>(
                listener: (context, state) {
              if (state is FetchingUserPhotosFailed) {
                AlertDialogs.showErrorDialog(context,
                    onClickAction: () => {
                          BlocProvider.of<UserPhotosBloc>(context)
                              .add(FetchUserPhotos(album.id))
                        });
              }
            }, builder: (context, state) {
              if (state is PostFetchUserPhotos) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () => FullScreenImageScreen.open(
                              context, state.photos[index].url),
                          child: Card(
                              color: Colors.white30,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            state.photos[index].thumbnailUrl),
                                      ),
                                    ),
                                  ),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Colors.transparent,
                                                  Colors.black12,
                                                  Colors.black26,
                                                  Colors.black38
                                                ])),
                                            width: double.infinity,
                                            padding: EdgeInsets.fromLTRB(
                                                8.0, 8.0, 8.0, 8.0),
                                            child: Text(
                                              state.photos[index].title,
                                              maxLines: 5,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ]),
                                ],
                              )));
                    });
              } else {
                return LoadingWidget();
              }
            }),
          )),
    );
  }

  static void open(BuildContext context, Album album) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserPhotosScreen(album)),
      );
}
