import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogs {
  static void showErrorDialog(
    BuildContext _context, {
    Function onClickAction,
    String title = 'Something went wrong!',
    String errorMsg = 'Please tap on retry in order to refresh the data.',
    String buttonTxt = 'Retry',
  }) {
    final fontFamily = DefaultTextStyle.of(_context).style.fontFamily;
    final style = TextStyle(fontFamily: fontFamily);
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title,
              style: Theme.of(_context).textTheme.subtitle1.copyWith(
                    color: Color(0xFF000000),
                  )),
          content: Text(errorMsg,
              style: Theme.of(_context).textTheme.bodyText2.copyWith(
                    color: Color(0xFF000000),
                  )),
          actions: [
            CupertinoDialogAction(
                child: Text(buttonTxt, style: style),
                isDefaultAction: true,
                onPressed: () {
                  if (onClickAction != null) {
                    onClickAction();
                  }
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
