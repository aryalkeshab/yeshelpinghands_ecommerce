import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {Color? color,isCenter=false}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity:isCenter?ToastGravity.CENTER: ToastGravity.BOTTOM,
      backgroundColor: color ?? Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showFailureToast(String message, {Color? color}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
