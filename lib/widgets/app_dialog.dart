import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  Widget content;
  String textCancel;
  String textConfirm;
  Function onConfirm;
  Function onCancel;
  Color colorConfirm;

  AppDialog(
    this.content, {
    this.textCancel,
    this.textConfirm,
    this.onConfirm,
    this.onCancel,
    this.colorConfirm,
  });

  show() => Get.defaultDialog(
        title: 'Fast Mobi',
        content: content,
        textCancel: textCancel != null ? textCancel : null,
        backgroundColor: Colors.black,
        onCancel: onCancel,
        confirm: RaisedButton(

          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Text(
            textConfirm != null? textConfirm : 'Sim',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: onConfirm,
        ),
      );
}
