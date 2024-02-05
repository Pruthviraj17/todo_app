import 'package:flutter/material.dart';

void showSnackBar({required String cnt, required BuildContext context}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cnt)));
}
