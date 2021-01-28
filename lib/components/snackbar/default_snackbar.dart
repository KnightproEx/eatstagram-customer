import 'package:flutter/material.dart';

SnackBar defaultSnackBar(String message) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}
