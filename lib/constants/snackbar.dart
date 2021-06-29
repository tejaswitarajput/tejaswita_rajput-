import 'package:demo_projec/constants/palette.dart';
import 'package:flutter/material.dart';

showSnackBar({
  @required BuildContext context,
  @required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 1500),
      width: 300,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Palette.primary,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      )));
}
