import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reap_book/model/user.dart';

class CardWidget extends StatelessWidget {
  final User user;
  final VoidCallback onItemClick;

  CardWidget({this.user, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: InkWell(
            onTap: () => onItemClick(),
            child: Container(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                              'https://random.imagecdn.app/150/150'),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 12, 0)),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.user.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 15,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                Text(
                                  this.user.email,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                Text(
                                  this.user.phone,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.web_outlined,
                                  size: 15,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                Text(
                                  this.user.website,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  size: 15,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                Text(
                                  this.user.address.city,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
}
