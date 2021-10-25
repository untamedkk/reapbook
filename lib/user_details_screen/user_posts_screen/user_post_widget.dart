import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reap_book/api/api_provider.dart';
import 'package:reap_book/api/api_repository.dart';
import 'package:reap_book/model/post.dart';
import 'package:reap_book/model/user.dart';
import 'package:reap_book/user_post_comments/user_post_comments_screen.dart';
import 'package:reap_book/utils/alert_dialogs.dart';
import 'package:reap_book/widgets/loading_widget.dart';

import 'user_details_screen_bloc.dart';
import 'user_details_screen_event.dart';
import 'user_details_screen_state.dart';

class UserPostWidget extends StatefulWidget {
  final User _user;
  final ScrollController _scrollController;

  UserPostWidget(this._user, this._scrollController);

  @override
  _UserPostWidgetState createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget>
    with AutomaticKeepAliveClientMixin<UserPostWidget> {
  List<Post> _posts = [];
  bool _showCreatePostButton = false;

  @override
  void initState() {
    _handleScroll();
    super.initState();
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RepositoryProvider<ApiRepository>(
      create: (context) {
        return ApiRepository(ApiProvider());
      },
      child: BlocProvider<UserDetailsScreenBloc>(
        create: (context) {
          final _apiRepository = RepositoryProvider.of<ApiRepository>(context);
          return UserDetailsScreenBloc(_apiRepository)
            ..add(FetchUserPost(widget._user.id));
        },
        child: BlocConsumer<UserDetailsScreenBloc, UserDetailsScreenState>(
            listener: (context, state) {
          if (state is FetchingUsersPostFailed) {
            AlertDialogs.showErrorDialog(context,
                onClickAction: () => {
                      BlocProvider.of<UserDetailsScreenBloc>(context)
                          .add(FetchUserPost(widget._user.id))
                    });
          }

          if (state is CreatePostSuccessful) {
            _posts.removeWhere((element) => element.id == state.post.id);
            _posts.add(state.post);
            BlocProvider.of<UserDetailsScreenBloc>(context)
                .add(UpdateNewPost());
          }

          if (state is UpdatePostSuccessful) {
            _posts.add(state.post);
            BlocProvider.of<UserDetailsScreenBloc>(context)
                .add(UpdateNewPost());
          }

          if (state is DeletePostSuccessful) {
            AlertDialogs.showSnackBar(context, 'Post deleted!!!');
          }

          if (state is DeletePostFailed) {
            AlertDialogs.showErrorDialog(context,
                errorMsg: 'Unable to delete the post!!!', buttonTxt: 'Ok');
          }

          if (state is CreatePostFailed) {
            AlertDialogs.showErrorDialog(context,
                errorMsg: 'Unable to create a post!!!', buttonTxt: 'Ok');
          }

          if (state is UpdatePostFailed) {
            Navigator.of(context).pop();
            AlertDialogs.showErrorDialog(context,
                errorMsg: 'Unable to update the post!!!', buttonTxt: 'Ok');
          }

          if (state is CreatePostSuccessful) {
            Navigator.of(context).pop();
            AlertDialogs.showSnackBar(context, 'Yay!!!');
          }

          if (state is UpdatePostSuccessful) {
            Navigator.of(context).pop();
            AlertDialogs.showSnackBar(context, 'Post updated successfully!!!');
          }
        }, builder: (context, state) {
          if (state is FetchingUserPost) {
            return LoadingWidget();
          }
          if (state is PostFetchUserPost) {
            _posts = state.posts;
          }

          return Stack(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                itemCount: _posts.length,
                //controller: _scrollController,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      child: ListTile(
                        onTap: () => {
                          UserPostCommentsScreen.open(
                              context, _posts[index], widget._user)
                        },
                        title: Text(_posts[index].title),
                        subtitle: Text(_posts[index].body),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit_outlined,
                        onTap: () => _updateCreatePostWidget(
                            context, true, widget._user.id,
                            post: _posts[index]),
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => _deletePost(context, _posts[index].id),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                child: AnimatedOpacity(
                  opacity: _showCreatePostButton ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 100),
                  child: FloatingActionButton(
                    onPressed: () => _updateCreatePostWidget(
                        context, false, widget._user.id),
                    child: Icon(Icons.post_add_sharp),
                  ),
                ),
                right: 15,
                bottom: 15,
              )
            ],
          );
        }),
      ));

  void _updateCreatePostWidget(
      BuildContext _context, bool isEditMode, int userId,
      {Post post}) {
    var titleEditTextController = TextEditingController(
      text: isEditMode ? post.title : '',
    );
    var bodyEditTextController =
        TextEditingController(text: isEditMode ? post.body : '');
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: 10,
                )),
                Text(
                  isEditMode ? 'Edit Post' : 'Create Post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: 15,
                )),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                  controller: titleEditTextController,
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: 15,
                )),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Body',
                  ),
                  controller: bodyEditTextController,
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: 10,
                )),
                RaisedButton(
                  child: Text(
                    isEditMode ? 'Update' : 'Post',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () => {
                    _hideKeyboard(_context),
                    if (isEditMode)
                      {
                        _updatePost(_context, titleEditTextController.text,
                            bodyEditTextController.text, userId, post.id)
                      }
                    else
                      {
                        _createPost(_context, titleEditTextController.text,
                            bodyEditTextController.text, userId)
                      }
                  },
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                )
              ],
            )),
      )),
    );
  }

  void _createPost(
          BuildContext context, String title, String body, int userId) =>
      BlocProvider.of<UserDetailsScreenBloc>(context)
          .add(CreatePost(body, title, userId));

  void _updatePost(BuildContext context, String title, String body, int userId,
          int id) =>
      BlocProvider.of<UserDetailsScreenBloc>(context)
          .add(UpdatePost(body, title, userId, id));

  void _deletePost(BuildContext context, int id) =>
      BlocProvider.of<UserDetailsScreenBloc>(context).add(DeletePost(id));

  void _hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
  }

  @override
  bool get wantKeepAlive => true;

  void _handleScroll() async {
    widget._scrollController.addListener(() {
      if (widget._scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _shouldShowCreatePostButton(true);
      }
      if (widget._scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _shouldShowCreatePostButton(false);
      }
    });
  }

  void _shouldShowCreatePostButton(bool flag) {
    setState(() {
      _showCreatePostButton = flag;
    });
  }
}
