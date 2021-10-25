import 'package:flutter/material.dart';
import 'package:reap_book/model/user.dart';

import 'user_albums_screen/user_albums_widget.dart';
import 'user_posts_screen/user_post_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;

  UserDetailsScreen(this.user);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();

  static void open(BuildContext context, User user) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailsScreen(user)),
      );
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.user.name),
                  background: Image.network(
                    'https://random.imagecdn.app/300/300',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: [
                      Container(
                        height: 50,
                        child: new Tab(text: 'Posts'),
                      ),
                      Container(
                        height: 50,
                        child: new Tab(text: 'Photos'),
                      ),
                    ],
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
                pinned: true,
              )
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: TabBarView(
              children: [
                UserPostWidget(widget.user, _scrollController),
                UserAlbumsWidget(widget.user.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: tabBar,
      color: Colors.white,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
