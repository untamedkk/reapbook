import 'package:flutter/material.dart';
import 'package:reap_book/model/user.dart';
import 'package:reap_book/user_details_screen/user_details_screen.dart';

import 'card_widget.dart';

class UsersListWidget extends StatelessWidget {
  final List<User> users;

  UsersListWidget(this.users);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.users.length,
      itemBuilder: (context, index) {
        return CardWidget(
            user: this.users[index],
            onItemClick: () => {UserDetailsScreen.open(context, users[index])});
      },
    );
  }
}
