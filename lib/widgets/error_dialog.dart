import 'dart:io';

import 'package:book_mate/models/custom_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, CustomError error){
 if (Platform.isIOS){
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(error.code),
        content: Text(error.message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
}
else {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(error.code),
      content: Text(error.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );}
}