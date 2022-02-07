import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subTitle) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
              elevation: 5,
              textColor: Colors.blue,
            ),
          ],
        );
      },
    );
  }
}
