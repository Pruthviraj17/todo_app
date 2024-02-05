import 'package:flutter/material.dart';
import 'package:todo_app/widgets/text_widget1.dart';

Future showAlertDialog({
  required BuildContext context,
  required Function() onTap,
  required String titile,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:
          TextWidget(title: titile, fontSize: 18, fontWeight: FontWeight.w700),
      content:
          TextWidget(title: content, fontSize: 14, fontWeight: FontWeight.w400),
      actions: [
        TextButton(
          onPressed: () {
            onTap();
            Navigator.of(context).pop();
          },
          child: TextWidget(
              title: "YES",
              fontSize: 14,
              fontColor: Colors.red,
              fontWeight: FontWeight.w400),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: TextWidget(
              title: "NO",
              fontSize: 14,
              fontColor: Colors.green,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
