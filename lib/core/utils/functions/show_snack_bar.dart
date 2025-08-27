import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Future<void> showToastMsg(BuildContext context, String msg) async {
  await Flushbar(
    message: msg,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: Colors.black87,
    messageColor: Colors.white,
    flushbarPosition: FlushbarPosition.TOP, // أو BOTTOM
  ).show(context);
}
