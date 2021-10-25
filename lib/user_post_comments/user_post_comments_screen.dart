import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reap_book/api/api_provider.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/model/post.dart';
import 'package:reap_book/model/user.dart';
import 'package:reap_book/utils/alert_dialogs.dart';
import 'package:reap_book/widgets/loading_widget.dart';

import 'comments_screen_bloc.dart';
import 'comments_screen_event.dart';
import 'comments_screen_state.dart';

class UserPostCommentsScreen extends StatefulWidget {
  final Post _post;
  final User _user;

  UserPostCommentsScreen(this._post, this._user);

  @override
  State<StatefulWidget> createState() => _UserPostCommentsScreenState();

  static void open(BuildContext context, Post post, User user) =>
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserPostCommentsScreen(post, user)),
      );
}

class _UserPostCommentsScreenState extends State<UserPostCommentsScreen> {
  int _commentsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_commentsCount > 0
              ? 'Comments (' + _commentsCount.toString() + ')'
              : 'Comments'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        NetworkImage('https://random.imagecdn.app/150/150'),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  Text(
                    widget._user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(widget._post.title),
              subtitle: Text(widget._post.body),
            ),
            const Divider(
              height: 20,
              thickness: 2,
            ),
            RepositoryProvider<ApiRepository>(
              create: (context) {
                return ApiRepository(ApiProvider());
              },
              child: BlocProvider<CommentsScreenBloc>(
                create: (context) {
                  final _apiRepository =
                      RepositoryProvider.of<ApiRepository>(context);
                  return CommentsScreenBloc(_apiRepository)
                    ..add(FetchUserComments(widget._post.id));
                },
                child: BlocConsumer<CommentsScreenBloc, CommentsScreenState>(
                  listener: (context, state) {
                    if (state is FetchingCommentsFailed) {
                      AlertDialogs.showErrorDialog(context,
                          onClickAction: () => {
                                BlocProvider.of<CommentsScreenBloc>(context)
                                    .add(FetchUserComments(widget._post.id))
                              });
                    }
                  },
                  builder: (context, state) {
                    if (state is PostFetchComments) {
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          _commentsCount = state.comments.length;
                        });
                      });

                      return Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  separatorBuilder: (context, index) => Divider(
                                        color: Colors.grey,
                                      ),
                                  itemCount: state.comments.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.comments[index].name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 8)),
                                        Text(
                                          state.comments[index].email,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 8)),
                                        Text(
                                          state.comments[index].body,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    );
                                  })));
                    }
                    return Expanded(
                      child: LoadingWidget(),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
